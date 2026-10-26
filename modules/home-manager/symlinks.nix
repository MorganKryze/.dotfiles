{ ... }:

# Raw config symlinks for tools without a usable Home-Manager module
# (or where the HM module would just be a passthrough). Configs that DO
# have an HM module live under apps/<name>/default.nix instead.
# See ../../docs/packaging.md for the config-source policy.
{
  home.file = {
    # Shell — hand-written rc files; programs.zsh stays off to avoid
    # the "Conflicting managed target files" error (see apps/zsh/default.nix).
    ".zshrc".source = ./apps/zsh/.zshrc;
    ".zshenv".source = ./apps/zsh/.zshenv;
    ".zprofile".source = ./apps/zsh/.zprofile;
    ".exports".source = ./shell/.exports;
    ".aliases".source = ./shell/.aliases;
    ".functions".source = ./shell/.functions;

    # Shell helpers sourced from .zshenv — no HM module for these.
    ".git_func".source = ./apps/git/.git_func;
    ".conda_func".source = ./apps/conda/.conda_func;
    ".yabai_func".source = ../macos/services/yabai/.yabai_func;

    # Git commit-msg hooks — file-based, install path is ~/.gitemojis/.
    ".gitemojis/commit-msg".source = ./apps/git/gitemojis/commit-msg;
    ".gitemojis/prepare-commit-msg".source = ./apps/git/gitemojis/prepare-commit-msg;

    # Tools with no HM module worth using.
    ".condarc".source = ./apps/conda/.condarc;
    ".curlrc".source = ./apps/curl/.curlrc;
    ".wezterm.lua".source = ./apps/wezterm/.wezterm.lua;
    ".config/ghostty/config".source = ./apps/ghostty/config;
    ".config/fastfetch/config.jsonc".source = ./apps/fastfetch/config.jsonc;
    ".config/tunny/destinations.toml".source = ./apps/tunny/destinations.toml;
    "Library/Application Support/superfile/config.toml".source = ./apps/superfile/config.toml;

    # VSCode — 400-line JSON, HM value is extension mgmt which we don't use.
    "Library/Application Support/Code/User/settings.json".source = ./apps/vscode/settings.json;
    "Library/Application Support/Code/User/keybindings.json".source = ./apps/vscode/keybindings.json;

    # Misc
    # ⚠️ Path RELATIVE to the flake, like every entry above. An ABSOLUTE nix path
    # (/Users/morgan/…) fails the whole evaluation: "access to absolute path '/Users' is
    # forbidden in pure evaluation mode". The `/Users/morgan` in home.nix and user.nix are
    # quoted STRINGS, which is harmless; this one was a path, so it was read at evaluation.
    ".hushlogin".source = ../../docs/assets/.hushlogin;
  };
}
