{ pkgs, ... }:
let
  # Modrinth App from the official AppImage: nixpkgs is stuck at 0.21.6 (even on
  # master, 2026-11-07) while upstream ships 0.23.1. Bump version + hash by hand
  # (`nix store prefetch-file <url>`) until nixpkgs catches up, then switch back
  # to pkgs.modrinth-app.
  modrinth-app =
    let
      pname = "modrinth-app";
      version = "0.23.1";
      src = pkgs.fetchurl {
        url = "https://github.com/modrinth/code/releases/download/v${version}/Modrinth.App_${version}_amd64.AppImage";
        hash = "sha256-/rBL9vOOI6Q1TF/0ag1pChpYcyex353azHeUcPpvLwk=";
      };
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    pkgs.appimageTools.wrapType2 {
      inherit pname version src;
      extraInstallCommands = ''
        source ${pkgs.makeWrapper}/nix-support/setup-hook
        # Tauri/WebKitGTK shows a blank window on NVIDIA without this
        wrapProgram $out/bin/${pname} --set WEBKIT_DISABLE_DMABUF_RENDERER 1
        install -Dm644 "${contents}/Modrinth App.desktop" $out/share/applications/modrinth-app.desktop
        substituteInPlace $out/share/applications/modrinth-app.desktop \
          --replace-fail "Exec=ModrinthApp" "Exec=${pname} %U"
        cp -r ${contents}/usr/share/icons $out/share/
      '';
    };
in
{
  programs.steam = {
    enable = true; # also sets hardware.graphics.enable32Bit
    extraCompatPackages = [ pkgs.proton-ge-bin ]; # GE-Proton: FSR 4 upgrade and game fixes
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
