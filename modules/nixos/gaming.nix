{ pkgs, ... }:
let
  # Modrinth App 0.23.1 from the official AppImage: nixpkgs is stuck at 0.21.6
  # (even on master, 2026-11-07). Bump version + hash by hand
  # (`nix store prefetch-file <url>`) until nixpkgs catches up, then switch back
  # to pkgs.modrinth-app.
  #
  # Only the ModrinthApp binary is kept: the libraries bundled in the AppImage
  # need glibc 2.43, newer than nixpkgs'. It is patched against nixpkgs' WebKitGTK
  # and handed to nixpkgs' wrapper, which provides Java and Minecraft's runtime libs.
  modrinth-app-unwrapped =
    let
      pname = "modrinth-app-unwrapped";
      version = "0.23.1";
      contents = pkgs.appimageTools.extract {
        inherit pname version;
        src = pkgs.fetchurl {
          url = "https://github.com/modrinth/code/releases/download/v${version}/Modrinth.App_${version}_amd64.AppImage";
          hash = "sha256-/rBL9vOOI6Q1TF/0ag1pChpYcyex353azHeUcPpvLwk=";
        };
      };
    in
    pkgs.stdenv.mkDerivation {
      inherit pname version;
      dontUnpack = true;
      nativeBuildInputs = [ pkgs.autoPatchelfHook ];
      buildInputs = with pkgs; [
        dbus
        glib
        gtk3
        libsoup_3
        webkitgtk_4_1
        (lib.getLib stdenv.cc.cc)
      ];
      installPhase = ''
        install -Dm755 ${contents}/usr/bin/ModrinthApp $out/bin/ModrinthApp
        patchelf --remove-rpath $out/bin/ModrinthApp
        install -Dm644 "${contents}/Modrinth App.desktop" $out/share/applications/ModrinthApp.desktop
        cp -r ${contents}/usr/share/icons $out/share/
      '';
      meta = pkgs.modrinth-app-unwrapped.meta;
    };
  # WebKitGTK's DMABUF renderer crashes on Wayland + NVIDIA (Wayland error 71)
  modrinth-app = pkgs.symlinkJoin {
    name = "modrinth-app-${modrinth-app-unwrapped.version}";
    paths = [ (pkgs.modrinth-app.override { inherit modrinth-app-unwrapped; }) ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/ModrinthApp --set WEBKIT_DISABLE_DMABUF_RENDERER 1
    '';
  };
in
{
  programs.steam = {
    enable = true; # also sets hardware.graphics.enable32Bit
    extraCompatPackages = [ pkgs.proton-ge-bin ]; # GE-Proton: FSR 4 upgrade and game fixes
  };
  # Modrinth downloads generic-Linux Zulu JREs for each instance: nix-ld lets them run.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      libx11
      libxext
      libxi
      libxrender
      libxtst
    ];
  };
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  users.users.morgan.extraGroups = [ "gamemode" ];

  environment.systemPackages = with pkgs; [
    lutris # Battle.net (install script + GE-Proton runner)
    modrinth-app # Minecraft (let-bound above, official AppImage)
    mangohud
    # Missing runtimes in a game's Proton prefix, e.g. Fallout 4:
    #   protontricks 377160 vcrun2022 arial
    protontricks
  ];
}
