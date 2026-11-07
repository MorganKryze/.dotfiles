{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btop
    curl
    fastfetch
    ghostty
    git
    pciutils # lspci
    usbutils # lsusb
    vim
    wget
    # ponytail: vscode 1.144.0 fails to build on nixos-26.05 (2026-11-07,
    # patchPhase: rm …/@vscode/ripgrep/bin/rg: No such file). Re-add once fixed.
  ];
}
