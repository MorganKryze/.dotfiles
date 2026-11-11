# NymVPN (mixnet / WireGuard VPN): not in nixpkgs (2026-11-11, only the `nym`
# mixnet binaries are), so packaged from upstream's prebuilt Linux release.
# Bump: change `version`, then refresh both hashes with
#   nix store prefetch-file <url>
{ pkgs, lib, ... }:
let
  version = "2026.15.0";
  release = "https://github.com/nymtech/nym-vpn-client/releases/download/nym-vpn-v${version}";

  # Daemon (nym-vpnd) and CLI (nym-vpnc)
  nym-vpn-core = pkgs.stdenv.mkDerivation {
    pname = "nym-vpn-core";
    inherit version;
    src = pkgs.fetchurl {
      url = "${release}/nym-vpn-core-v${version}_linux_x86_64.tar.gz";
      hash = "sha256-SkbS2fs9ytC8r3PvHrw7/PDyjq1M1TAEsM7QuMTgD80=";
    };
    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = with pkgs; [
      dbus
      libmnl
      libnftnl
      openssl
      stdenv.cc.cc.lib
    ];
    installPhase = ''
      install -Dm755 -t $out/bin nym-vpnd nym-vpnc
    '';
    meta.platforms = [ "x86_64-linux" ];
  };

  # Desktop app (Tauri), talks to nym-vpnd
  nym-vpn-app = pkgs.stdenv.mkDerivation {
    pname = "nym-vpn-app";
    inherit version;
    src = pkgs.fetchurl {
      url = "${release}/nym-vpn-app_${version}_amd64.deb";
      hash = "sha256-rF62mPoOxoiGCWaLqSC4CxdgBmnG7ZET+NA/LmG0pbQ=";
    };
    nativeBuildInputs = with pkgs; [
      autoPatchelfHook
      dpkg
      wrapGAppsHook3
    ];
    buildInputs = with pkgs; [
      gtk3
      libsoup_3
      openssl
      webkitgtk_4_1
      stdenv.cc.cc.lib
    ];
    # Tray icon, loaded at runtime
    runtimeDependencies = [ pkgs.libayatana-appindicator ];
    unpackPhase = "dpkg-deb -x $src .";
    installPhase = ''
      mkdir -p $out
      cp -r usr/* $out/
      substituteInPlace $out/share/applications/NymVPN.desktop \
        --replace-fail "Categories=" "Categories=Network;"
    '';
    meta.platforms = [ "x86_64-linux" ];
  };
in
{
  environment.systemPackages = [
    nym-vpn-core
    nym-vpn-app
  ];

  # Upstream's unit (deb's nym-vpnd.service), run as root
  systemd.services.nym-vpnd = {
    description = "nym-vpnd daemon";
    before = [ "network-online.target" ];
    after = [ "NetworkManager.service" ];
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.iproute2 ];
    startLimitBurst = 6;
    startLimitIntervalSec = 24;
    serviceConfig = {
      ExecStart = "${nym-vpn-core}/bin/nym-vpnd -v run-as-service";
      Restart = "always";
      RestartSec = 2;
    };
  };

  # nym-vpnd calls `ip` by absolute path (/sbin/ip, /usr/sbin/ip, /usr/bin/ip),
  # none of which exists on NixOS: without it, the tunnel fails with
  # "TunDevice: failed to set tunnel device ipv6 address".
  systemd.tmpfiles.rules = [ "L+ /usr/bin/ip - - - - ${pkgs.iproute2}/bin/ip" ];

  # Upstream's sysusers.d: members may drive the daemon
  users.groups.nym-vpn = { };
  users.users.morgan.extraGroups = [ "nym-vpn" ];

  # The strict reverse-path check drops WireGuard replies on the tunnel
  networking.firewall.checkReversePath = lib.mkDefault "loose";
}
