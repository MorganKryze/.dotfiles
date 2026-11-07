{ pkgs, ... }:
{
  # Same Nerd Fonts as the Mac (Homebrew casks): starship and lsd icons
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.symbols-only
  ];
}
