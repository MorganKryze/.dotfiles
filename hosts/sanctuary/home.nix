# Home-Manager profile for the Linux tower. It reuses the cross-platform app
# modules and shell files of the Mac. The Mac's zsh rc files are left out: they
# source Homebrew paths; zsh is set up natively below and sources the same
# .aliases / .functions / .git_func, whose macOS-only parts are guarded by
# `[[ "$OSTYPE" == darwin* ]]`.
{ pkgs, ... }:
let
  hm = ../../modules/home-manager;
in
{
  imports = [
    "${hm}/apps/git"
    "${hm}/apps/starship"
    "${hm}/apps/tmux"
    "${hm}/apps/nushell"
  ];

  home = {
    username = "morgan";
    homeDirectory = "/home/morgan";
    stateVersion = "26.05";
  };

  # CLI tools the Mac gets from Homebrew (modules/macos/homebrew.nix) or
  # modules/macos/packages.nix
  home.packages = with pkgs; [
    # files and search
    fd
    fzf
    lsd
    p7zip
    ripgrep
    superfile
    # text and data
    jq
    micro
    pandoc
    typst
    # dev
    actionlint
    gh
    gitflow
    go
    just
    nixd
    nixfmt
    nodejs
    pnpm
    shellcheck
    uv
    # media
    ffmpeg
    imagemagick
    yt-dlp
    # system and network
    htop
    openssl
    socat
    # secrets: sops/age, and secscan (gitleaks + trufflehog)
    age
    gitleaks
    sops
    trufflehog
    # `luck` and friends
    cmatrix
    cowsay
    fortune
    sl
  ];

  home.sessionVariables = {
    EDITOR = "micro";
    SOPS_AGE_KEY_FILE = "$HOME/.config/sops/age/keys.txt";
  };
  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
    ];
    # Same start-up as the Mac's .zshrc, minus Homebrew and nix-update-check
    initContent = ''
      fastfetch -c $HOME/.config/fastfetch/config.jsonc -l NixOS
      source $HOME/.dotfiles/dependencies/bash-toolbox/src/prefix.sh
      for file in ~/.{aliases,functions,git_func}; do
        [ -r "$file" ] && source "$file"
      done
      unset file

      # Keep hash commands (with secrets as arguments) out of the history
      function zshaddhistory() {
        [[ $1 == shasum* || $1 == hash* || $1 == shash* ]] && return 1
        return 0
      }
    '';
  };
  programs.zoxide.enable = true;

  home.file = {
    ".aliases".source = "${hm}/shell/.aliases";
    ".functions".source = "${hm}/shell/.functions";
    ".git_func".source = "${hm}/apps/git/.git_func";
    ".gitemojis/commit-msg".source = "${hm}/apps/git/gitemojis/commit-msg";
    ".gitemojis/prepare-commit-msg".source = "${hm}/apps/git/gitemojis/prepare-commit-msg";
    ".config/fastfetch/config.jsonc".source = "${hm}/apps/fastfetch/config.jsonc";
    ".config/ghostty/config".source = "${hm}/apps/ghostty/config";
    ".curlrc".source = "${hm}/apps/curl/.curlrc";
    ".hushlogin".source = ../../docs/assets/.hushlogin;
  };

  # Raycast-like launcher. Bind a key in System Settings > Keyboard > Shortcuts
  # (see docs/nixos.md); KRunner (Alt+Space) remains as a fallback.
  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
  };

  # Keys live in ~/.ssh/private and ~/.ssh/public, like on the Mac. The agent
  # (programs.ssh.startAgent, modules/nixos/networking.nix) keeps the passphrase
  # after the first use in a session.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "github.com gitlab.com" = {
        IdentityFile = "~/.ssh/private/git";
        IdentitiesOnly = "yes";
        AddKeysToAgent = "yes";
      };
      "git.libresoftware.cloud" = {
        Port = 2222;
        IdentityFile = "~/.ssh/private/git";
        IdentitiesOnly = "yes";
        AddKeysToAgent = "yes";
      };
    };
  };

  programs.home-manager.enable = true;
}
