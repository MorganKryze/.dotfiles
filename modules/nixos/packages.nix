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
  ];
}
