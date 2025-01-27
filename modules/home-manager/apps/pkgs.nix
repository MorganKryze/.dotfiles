{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal utilities
    gitflow
    nixd
    nixfmt-rfc-style
    fastfetch
    starship

    # Docker utilities
    lazydocker
    neo-cowsay
    localsend
    thefuck

    # Apps
    superfile
  ];
}
