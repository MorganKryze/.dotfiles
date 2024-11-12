{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # App aliases
    mkalias

    # Terminal utilities
    gitflow
    nixd
    nixfmt-rfc-style
    fastfetch
    starship

    # Docker utilities
    lazydocker
    neo-cowsay
  ];
}
