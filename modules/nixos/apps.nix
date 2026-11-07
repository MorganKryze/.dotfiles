{ pkgs, pkgs-unstable, ... }:
{
  environment.systemPackages = [
    # VS Code 1.144.0 fails to build on nixos-26.05 (2026-11-07, patchPhase:
    # rm …/@vscode/ripgrep/bin/rg: No such file) but builds on unstable.
    pkgs-unstable.vscode
    # Claude Code moves weekly: unstable, bumped by nix-update
    pkgs-unstable.claude-code
    pkgs.bitwarden-desktop
  ];

  # LocalSend: file transfers with the Mac and phones on the LAN (port 53317)
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}
