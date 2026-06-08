{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal utilities
    gitflow
    nixd
    nixfmt-rfc-style
    shellcheck # shell script linter
    actionlint # GitHub Actions workflow linter
    fastfetch
    starship
    nushell
    # Docker utilities
    lazydocker
    localsend

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
