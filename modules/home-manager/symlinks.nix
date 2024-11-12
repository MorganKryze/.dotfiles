{ ... }:

{
  home.file = {
    ".gitconfig".source = /Users/morgan/.dotfiles/apps/git/.gitconfig;
    ".git_func".source = /Users/morgan/.dotfiles/apps/git/.git_func;
    ".gitemojis/commit-msg".source = /Users/morgan/.dotfiles/apps/git/gitemojis/commit-msg;
    ".gitemojis/prepare-commit-msg".source = /Users/morgan/.dotfiles/apps/git/gitemojis/prepare-commit-msg;

    ".zshrc".source = /Users/morgan/.dotfiles/apps/zsh/.zshrc;
    ".zshenv".source = /Users/morgan/.dotfiles/apps/zsh/.zshenv;
    ".zprofile".source = /Users/morgan/.dotfiles/apps/zsh/.zprofile;
    ".exports".source = /Users/morgan/.dotfiles/apps/zsh/.exports;
    ".aliases".source = /Users/morgan/.dotfiles/apps/zsh/.aliases;
    ".functions".source = /Users/morgan/.dotfiles/apps/zsh/.functions;
    ".yabai_func".source = /Users/morgan/.dotfiles/apps/yabai/.yabai_func;

    ".condarc".source = /Users/morgan/.dotfiles/apps/conda/.condarc;
    ".conda_func".source = /Users/morgan/.dotfiles/apps/conda/.conda_func;

    "Library/Application Support/Code/User/settings.json".source = /Users/morgan/.dotfiles/apps/vscode/settings.json;
    "Library/Application Support/Code/User/keybindings.json".source = /Users/morgan/.dotfiles/apps/vscode/keybindings.json;

    ".hushlogin".source = /Users/morgan/.dotfiles/docs/assets/.hushlogin;
    ".curlrc".source = /Users/morgan/.dotfiles/apps/curl/.curlrc;
    ".config/yazi/theme.toml".source = /Users/morgan/.dotfiles/apps/yazi/theme.toml;
    ".config/yazi/yazi.toml".source = /Users/morgan/.dotfiles/apps/yazi/yazi.toml;
    ".config/starship.toml".source = /Users/morgan/.dotfiles/apps/starship/starship.toml;
    ".wezterm.lua".source = /Users/morgan/.dotfiles/apps/wezterm/.wezterm.lua;
    ".config/fastfetch/config.jsonc".source = /Users/morgan/.dotfiles/apps/fastfetch/config.jsonc;
  };
}
