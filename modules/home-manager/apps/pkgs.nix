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
    localsend
    thefuck

    # Apps
    # Superfile: a TUI file manager.
    superfile
    # Wezterm: GPU-accelerated terminal emulator.
    wezterm

    # Dependencies
    openssl
    cmake
    pkg-config
    curl
  ];
}
