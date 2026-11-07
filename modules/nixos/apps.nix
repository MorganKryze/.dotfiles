{ pkgs, pkgs-unstable, ... }:
{
  environment.systemPackages = [
    # VS Code 1.144.0 fails to build on nixos-26.05 (2026-11-07, patchPhase:
    # rm …/@vscode/ripgrep/bin/rg: No such file) but builds on unstable.
    pkgs-unstable.vscode
    # Claude Code moves weekly: unstable, bumped by nix-update
    pkgs-unstable.claude-code
    pkgs.bitwarden-desktop
    # communication
    pkgs.discord
    pkgs.signal-desktop
    # office and media
    pkgs.libreoffice-qt6-fresh
    pkgs.obs-studio
    pkgs.mpv
    pkgs.jellyfin-media-player
    # CAD and 3D printing
    pkgs.freecad
    pkgs.orca-slicer
    # dev
    pkgs.lazydocker
  ];

  virtualisation.docker.enable = true;
  users.users.morgan.extraGroups = [ "docker" ]; # root-equivalent, accepted for dev

  # Local LLM inference on the RTX 5070 Ti, API on localhost:11434.
  # CUDA builds are unfree, so not in the binary cache: compiled locally, for
  # Blackwell (sm_120) only to keep the build short.
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda.override { cudaArches = [ "sm_120" ]; };
  };

  # LocalSend: file transfers with the Mac and phones on the LAN (port 53317)
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}
