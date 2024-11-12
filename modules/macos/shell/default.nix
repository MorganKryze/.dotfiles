{ pkgs, ... }:

{
  programs.zsh.enable = true;

  # Must have packages
  environment.systemPackages = with pkgs; [
    # App aliases
    mkalias

    # Terminal utilities
    openssh
    nmap
    gmp
    curl
    wget
  ];
}
