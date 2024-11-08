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
    ".wezterm.lua".source = ~/.dotfiles/apps/wezterm/.wezterm.lua;
    ".config/fastfetch/config.jsonc".source = ~/.dotfiles/apps/fastfetch/config.jsonc;
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      # shellAliases = {
      #   # Git navigation branches
      #   main = "cd ../main";
      #   dev = "cd ../dev";

      #   # Files
      #   dr = "lsd -lah";

      #   # Nix
      #   nix-create-flake = "nix flake init -t nix-darwin --extra-experimental-features \"nix-command flakes\"";
      #   nix-update = "cd ~/.dotfiles/scripts && nix flake update --impure && darwin-rebuild switch --flake ~/.dotfiles/scripts#concord --impure ; cd -";

      #   # Shortcuts
      #   dl = "cd ~/Downloads";
      #   dt = "cd ~/Desktop";
      #   p = "cd ~/Documents/02-dev/02-git/01-morgankryze";
      #   pdvfl = "cd ~/Documents/02-dev/02-git/02-devinci\\ fablab";
      #   pdvb = "cd ~/Documents/02-dev/02-git/03-travelers";

      #   # VSCode
      #   opn = "code .;exit;";
      #   reopn = "code -r .";

      #   # Docker
      #   lzd = "lazydocker";
      #   d = "docker";
      #   dc = "docker compose";
      #   dcu = "docker compose up -d";
      #   dcd = "docker compose down";
      #   db-reboot = "dcd && rm -rf ./db && dcu";

      #   # Languages
      #   net = "dotnet";

      #   # Python
      #   py = "python";
      #   pip-req = "pip list --format=freeze > requirements.txt";

      #   # Node - Astro
      #   astro-dev = "pnpm run dev";

      #   # Always enable colored `grep` output
      #   grep = "grep --color=auto";
      #   fgrep = "fgrep --color=auto";
      #   egrep = "egrep --color=auto";

      #   # Copy utils
      #   copy = "| pbcopy";

      #   # Get week number
      #   week = "date +%V";

      #   # Mailsy
      #   mail-new = "mailsy g";
      #   mail-read = "mailsy m";
      #   mail-show = "mailsy me";
      #   mail-delete = "mailsy d";

      #   # IP addresses
      #   localip = "ipconfig getifaddr en0";
      #   ips = "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'";

      #   # Recursively delete `.DS_Store` files
      #   cleanup = "find . -type f -name '*.DS_Store' -ls -delete";

      #   # Empty the Trash on all mounted volumes and the main HDD.
      #   # Also, clear Apple’s System Logs to improve shell startup speed.
      #   # Finally, clear download history from quarantine. https://mths.be/bum
      #   emptytrash = "sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'";

      #   # Stuff I never really use but cannot delete either because of http://xkcd.com/530/
      #   stfu = "osascript -e 'set volume output muted true'";
      #   pumpitup = "osascript -e 'set volume output volume 100'";

      #   # Space
      #   getsize = "du -h -s */ | sort -rh";

        

      #   # SSH connexions
      #   fablab = "ssh morgan@devinci-fablab.fr";

      #   # Copy safely
      #   copier = "rsync -avh --progress --partial";

      #   # Gradle
      #   kotlin-new = "gradle init --type kotlin-application --dsl kotlin --test-framework kotlintest --java-version 21 --project-name";
      #   java-new = "gradle init --type java-application --dsl kotlin --test-framework junit --java-version 21 --project-name";

      #   # Android emulator
      #   start-and-emulator = "~/Library/Android/sdk/emulator/emulator -avd Medium_Phone_API_35";
      #   list-and-emulators = "~/Library/Android/sdk/emulator/emulator -list-avds";
      # };
      # oh-my-zsh = {
      #   enable = true;
      #   plugins = [
      #     "git"
      #     "zsh-autosuggestions"
      #     "zsh-syntax-highlighting"
      #   ];
      #   theme = "bira";
      # };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
