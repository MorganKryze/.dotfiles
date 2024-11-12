{
  description = "Concord configuration.";

  # All repositories links for specific packages
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
    }:
    let
      configuration =
        {
          pkgs,
          ...
        }:
        {
          nix = {
            package = pkgs.nix;
            useDaemon = true;
            configureBuildUsers = true;
            gc = {
              automatic = true;
              options = "--delete-older-than 14d";
            };
            optimise.automatic = true;
            nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
            settings = {
              experimental-features = [
                "nix-command"
                "flakes"
              ];
            };
            extraOptions = ''
              extra-platforms = x86_64-darwin aarch64-darwin
            '';
          };
          environment.systemPackages = with pkgs; [
            # App aliases
            mkalias

            # Terminal utilities
            gitflow
            nixd
            nixfmt-rfc-style
            fastfetch
            starship

            # Docker utilities
            lazydocker
            neo-cowsay
          ];

          homebrew = {
            # Will remove all the packages that are not in the configuration
            onActivation.cleanup = "zap";
            enable = true;
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;

            # Taps
            taps = [
            ];

            # Non-cask apps
            brews = [
              # Core utilities
              "p7zip"
              "poppler"
              "pkg-config"
              "graphviz"
              "ffmpegthumbnailer"
              "sevenzip"
              "jq"
              "fd"
              "ripgrep"
              "fzf"
              "zoxide"
              "imagemagick"

              # Langs
              "php"
              "pnpm"
              "openjdk"
              "gradle"

              # Terminal
              "htop"
              "btop"
              "lsd"
              "zsh-autosuggestions"
              "zsh-syntax-highlighting"
              "zsh-autopair"
              "micro"

              # Dockers
              "postgresql@14"

              # Kubernetes
              "kubernetes-cli"
              "helm"
              "k9s"
              "kind"

              # Virtualization
              "qemu"

              # Games
              "cmatrix"
              "fortune"
              "sl"

              # Tools
              "mailsy"
              "yazi"
              "cowsay"
              "pygments"
            ];

            # Cask apps
            casks = [
              # Fonts
              "font-symbols-only-nerd-font"
              "font-hack-nerd-font"

              # Docker
              "docker"
              "miniconda"

              # Virtualization
              "vagrant"
              "virtualbox"
              "raspberry-pi-imager"
              "crystalfetch"
              "balenaetcher"
              "virtualbuddy"

              # ObjectiveSee & Safety
              "oversight"
              "lulu"
              "knockknock"
              "blockblock"
              "reikey"
              "bitwarden"
              # "protonvpn"
              "surfshark"

              # Browsers
              "arc"
              "zen-browser"
              "tor-browser"

              # Dev apps
              "visual-studio-code"
              "devtoys"
              "android-studio"
              "mactex"
              "applite"
              "wezterm"

              # Productivity
              "notion"
              "raycast"
              "maccy"
              "cheatsheet"
              "libreoffice"

              # 3D & Design
              "autodesk-fusion"
              "orcaslicer"
              # "lycheeslicer"
              "kicad"
              "drawio"

              # Media
              "iina"
              "imageoptim"
              "inkscape"
              "flameshot"
              "handbrake"
              "adobe-acrobat-reader"
              "obs"

              # Communication
              "thunderbird@esr"
              "signal"
              "discord"
              "telegram"

              # Utilities
              "onyx"
              "appcleaner"
              "the-unarchiver"
              "stats"
              "keyboardcleantool"
              "mediamate"
              "lunar"
              "parsec"
              "jdownloader"

              # Games & Emulators
              "steam"
              "crossover"
              "whisky"
              "battle-net"
              "modrinth"
            ];

            # Mac App Store apps
            masApps = { };
          };

          home-manager.backupFileExtension = "backup";

          system.configurationRevision = self.rev or self.dirtyRev or null;

          services = {
            nix-daemon = {
              enable = true;
            };
            yabai = {
              enable = true;
              package = pkgs.yabai;
              enableScriptingAddition = true;
              config = {
                focus_follows_mouse = "autoraise";
                mouse_follows_focus = "off";
                window_placement = "second_child";
                window_opacity = "off";
                window_opacity_duration = "0.0";
                window_border = "on";
                window_border_placement = "inset";
                window_border_width = 2;
                window_border_radius = 3;
                active_window_border_topmost = "off";
                window_topmost = "on";
                window_shadow = "float";
                active_window_border_color = "0xff5c7e81";
                normal_window_border_color = "0xff505050";
                insert_window_border_color = "0xffd75f5f";
                active_window_opacity = "1.0";
                normal_window_opacity = "1.0";
                split_ratio = "0.50";
                auto_balance = "on";
                mouse_modifier = "alt";
                mouse_action1 = "move";
                mouse_action2 = "resize";
                layout = "bsp";
                top_padding = 12;
                bottom_padding = 12;
                left_padding = 12;
                right_padding = 12;
                window_gap = 12;
              };

              extraConfig = ''
                # rules
                yabai -m rule --add app="^System Settings$" manage=off
                yabai -m rule --add app="^Onyx$" manage=off
                yabai -m rule --add app="^Lunar$" manage=off
                yabai -m rule --add app="^Finder$" manage=on
              '';
            };
            skhd = {
              enable = true;
              package = pkgs.skhd;
              skhdConfig = ''
                #move window to prev and next space
                ctrl + alt - p : yabai -m window --space prev;
                ctrl + alt - n : yabai -m window --space next;

                # move window to space #
                shift + alt - 1 : yabai -m window --space 1;
                shift + alt - 2 : yabai -m window --space 2;
                shift + alt - 3 : yabai -m window --space 3;
                shift + alt - 4 : yabai -m window --space 4;
                shift + alt - 5 : yabai -m window --space 5;
                shift + alt - 6 : yabai -m window --space 6;
                shift + alt - 7 : yabai -m window --space 7;

                # move window and split
                ctrl + alt - down : yabai -m window --warp south
                ctrl + alt - up : yabai -m window --warp north
                ctrl + alt - left : yabai -m window --warp west
                ctrl + alt - right : yabai -m window --warp east
              '';

            };
          };

        };
    in
    {
      darwinConfigurations."concord" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "morgan";
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.morgan = import ../modules/home-manager;
          }
          ../modules/macos
          ../hosts/concord
        ];
      };
      darwinPackages = self.darwinConfigurations."concord".pkgs;
    };
}
