{ ... }:

{
  # `programs.zsh` is intentionally NOT enabled: the hand-written `.zshrc` /
  # `.zshenv` / `.zprofile` are managed directly via `home.file` in
  # ../../symlinks.nix, and the zsh plugins (autosuggestions, syntax-highlighting,
  # autopair) are installed by Homebrew and sourced from that `.zshrc`.
  # Enabling `programs.zsh` would make home-manager generate its own
  # `.zshrc`/`.zshenv`, which collides with those symlinks — a hard error since
  # home-manager 25.11 ("Conflicting managed target files").
}
