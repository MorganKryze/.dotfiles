{ pkgs, ... }:

# Default landing spot for system-scope nix packages. Before adding here,
# check ../../docs/packaging.md — CLI dev tools usually belong in
# homebrew.nix, and anything with a programs.* HM module belongs there.
{
  environment.systemPackages = with pkgs; [
    # Nix tooling
    nixd                # nix LSP
    nixfmt-rfc-style    # nix formatter

    # Linters used by editor integrations
    shellcheck
    actionlint

    # Misc utilities with no clear brew/HM home
    gitflow
    lazydocker
    localsend

    # TUI / terminal apps with configs in modules/home-manager/apps/
    fastfetch           # system info banner (called from .zshrc)
    superfile           # TUI file manager
    wezterm             # GPU-accelerated terminal emulator

    # System-scope build/runtime deps
    openssl
  ];
}
