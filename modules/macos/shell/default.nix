{ pkgs, ... }:

{
  programs.zsh.enable = true;

  # Must have packages
  environment.systemPackages = with pkgs; [
    openssh
    nmap
    gmp
    curl
    wget
  ];
}
