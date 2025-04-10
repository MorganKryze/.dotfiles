{ ... }:

{
  home.file = {
    ".gitconfig".source = ./apps/git/.gitconfig;
    ".git_func".source = ./apps/git/.git_func;
    ".gitemojis/commit-msg".source = ./apps/git/gitemojis/commit-msg;
    ".gitemojis/prepare-commit-msg".source = ./apps/git/gitemojis/prepare-commit-msg;

    ".zshrc".source = ./apps/zsh/.zshrc;
    ".zshenv".source = ./apps/zsh/.zshenv;
    ".zprofile".source = ./apps/zsh/.zprofile;
    
    ".yabai_func".source = ./apps/yabai/.yabai_func;

    ".exports".source = ./shell/zsh/.exports;
    ".aliases".source = ./shell/zsh/.aliases;
    ".functions".source = ./shell/zsh/.functions;

    ".condarc".source = ./apps/conda/.condarc;
    ".conda_func".source = ./apps/conda/.conda_func;

    "Library/Application Support/Code/User/settings.json".source = ./apps/vscode/settings.json;
    "Library/Application Support/Code/User/keybindings.json".source = ./apps/vscode/keybindings.json;

    ".hushlogin".source = /Users/morgan/.dotfiles/docs/assets/.hushlogin;
    ".curlrc".source = ./apps/curl/.curlrc;
    "Library/Application Support/superfile/config.toml".source = ./apps/superfile/config.toml;
    ".config/starship.toml".source = ./apps/starship/starship.toml;
    ".wezterm.lua".source = ./apps/wezterm/.wezterm.lua;
    ".config/ghostty/config".source = ./apps/ghostty/config;
    ".config/fastfetch/config.jsonc".source = ./apps/fastfetch/config.jsonc;
  };
}
