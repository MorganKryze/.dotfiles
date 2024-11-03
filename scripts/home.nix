{ config, pkgs, ... }:

{
  home.username = "morgan";
  home.homeDirectory = "/Users/morgan";
  home.stateVersion = "24.05";

  home.file = {
    ".gitconfig".source = ~/.dotfiles/apps/git/.gitconfig;
    ".git_func".source = ~/.dotfiles/apps/git/.git_func;
    ".gitemojis/commit-msg".source = ~/.dotfiles/apps/git/gitemojis/commit-msg;
    ".gitemojis/prepare-commit-msg".source = ~/.dotfiles/apps/git/gitemojis/prepare-commit-msg;

    ".zshrc".source = ~/.dotfiles/apps/zsh/.zshrc;
    ".zshenv".source = ~/.dotfiles/apps/zsh/.zshenv;
    ".zprofile".source = ~/.dotfiles/apps/zsh/.zprofile;
    ".exports".source = ~/.dotfiles/apps/zsh/.exports;
    ".aliases".source = ~/.dotfiles/apps/zsh/.aliases;
    ".functions".source = ~/.dotfiles/apps/zsh/.functions;

    ".yabairc".source = ~/.dotfiles/apps/yabai/.yabairc;
    ".skhdrc".source = ~/.dotfiles/apps/yabai/.skhdrc;
    ".yabai_func".source = ~/.dotfiles/apps/yabai/.yabai_func;

    ".condarc".source = ~/.dotfiles/apps/conda/.condarc;
    ".conda_func".source = ~/.dotfiles/apps/conda/.conda_func;

    "Library/Application Support/Code/User/settings.json".source = ~/.dotfiles/apps/vscode/settings.json;
    "Library/Application Support/Code/User/keybindings.json".source = ~/.dotfiles/apps/vscode/keybindings.json;

    ".hushlogin".source = ~/.dotfiles/docs/assets/.hushlogin;
    ".curlrc".source = ~/.dotfiles/apps/curl/.curlrc;
    ".config/yazi/theme.toml".source = ~/.dotfiles/apps/yazi/theme.toml;
    ".config/yazi/yazi.toml".source = ~/.dotfiles/apps/yazi/yazi.toml;
    ".config/starship.toml".source = ~/.dotfiles/apps/starship/starship.toml;
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
    };
    starship = {
      enable = true;
    };
  };
}
