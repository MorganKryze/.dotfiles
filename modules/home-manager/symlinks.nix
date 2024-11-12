{ ... }:

{
  home.file = {
    ".gitconfig".source = /Users/morgan/.dotfiles/modules/home-manager/apps/git/.gitconfig;
    ".git_func".source = /Users/morgan/.dotfiles/modules/home-manager/apps/git/.git_func;
    ".gitemojis/commit-msg".source = /Users/morgan/.dotfiles/modules/home-manager/apps/git/gitemojis/commit-msg;
    ".gitemojis/prepare-commit-msg".source = /Users/morgan/.dotfiles/modules/home-manager/apps/git/gitemojis/prepare-commit-msg;

    ".zshrc".source = /Users/morgan/.dotfiles/modules/home-manager/apps/zsh/.zshrc;
    ".zshenv".source = /Users/morgan/.dotfiles/modules/home-manager/apps/zsh/.zshenv;
    ".zprofile".source = /Users/morgan/.dotfiles/modules/home-manager/apps/zsh/.zprofile;
    ".exports".source = /Users/morgan/.dotfiles/modules/home-manager/apps/zsh/.exports;
    ".aliases".source = /Users/morgan/.dotfiles/modules/home-manager/apps/zsh/.aliases;
    ".functions".source = /Users/morgan/.dotfiles/modules/home-manager/apps/zsh/.functions;
    ".yabai_func".source = /Users/morgan/.dotfiles/modules/home-manager/apps/yabai/.yabai_func;

    ".condarc".source = /Users/morgan/.dotfiles/modules/home-manager/apps/conda/.condarc;
    ".conda_func".source = /Users/morgan/.dotfiles/modules/home-manager/apps/conda/.conda_func;

    "Library/Application Support/Code/User/settings.json".source = /Users/morgan/.dotfiles/modules/home-manager/apps/vscode/settings.json;
    "Library/Application Support/Code/User/keybindings.json".source = /Users/morgan/.dotfiles/modules/home-manager/apps/vscode/keybindings.json;

    ".hushlogin".source = /Users/morgan/.dotfiles/docs/assets/.hushlogin;
    ".curlrc".source = /Users/morgan/.dotfiles/modules/home-manager/apps/curl/.curlrc;
    ".config/yazi/theme.toml".source = /Users/morgan/.dotfiles/modules/home-manager/apps/yazi/theme.toml;
    ".config/yazi/yazi.toml".source = /Users/morgan/.dotfiles/modules/home-manager/apps/yazi/yazi.toml;
    ".config/starship.toml".source = /Users/morgan/.dotfiles/modules/home-manager/apps/starship/starship.toml;
    ".wezterm.lua".source = /Users/morgan/.dotfiles/modules/home-manager/apps/wezterm/.wezterm.lua;
    ".config/fastfetch/config.jsonc".source = /Users/morgan/.dotfiles/modules/home-manager/apps/fastfetch/config.jsonc;
  };
}
