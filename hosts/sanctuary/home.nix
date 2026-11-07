# Home-Manager profile for the Linux tower. It reuses the cross-platform app
# modules of the Mac and leaves out symlinks.nix, whose zsh files source
# Homebrew paths that do not exist on Linux.
{ ... }:
{
  imports = [
    ../../modules/home-manager/apps/git
    ../../modules/home-manager/apps/starship
    ../../modules/home-manager/apps/tmux
    ../../modules/home-manager/apps/nushell
  ];

  home = {
    username = "morgan";
    homeDirectory = "/home/morgan";
    stateVersion = "26.05";
  };

  # Native zsh setup on Linux; the Mac keeps its hand-written rc files.
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  home.file.".config/ghostty/config".source = ../../modules/home-manager/apps/ghostty/config;

  programs.home-manager.enable = true;
}
