{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal utilities
    gitflow
    nixd
    nixfmt-rfc-style
    fastfetch
    starship
    nushell
    # Docker utilities
    lazydocker
    neo-cowsay
    localsend
    thefuck

    # Apps
    superfile

    # Dependencies
    openssl
    cmake
    pkg-config
    curl
  ];
}
