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
          config,
          ...
        }:
        {
          environment.systemPackages = with pkgs; [
            # App aliases
            mkalias

            # Core utilities
            openssh
            nmap
            gmp
            curl
            wget

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
              "koekeishiya/formulae"
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

              # Tiling managers
              "koekeishiya/formulae/yabai"
              "koekeishiya/formulae/skhd"

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

          # MacOS default settings
          # Documentation found at: https://mynixos.com/nix-darwin/options/system.defaults
          system = {
            stateVersion = 5;
            configurationRevision = self.rev or self.dirtyRev or null;
            startup.chime = false;
            activationScripts = {
              # Set up the alias for applications to be indexed by Spotlight
              applications = {
                text = ''
                  echo "setting up /Applications..." >&2
                  rm -rf /Applications/Nix\ Apps
                  mkdir -p /Applications/Nix\ Apps
                  find ${
                    pkgs.buildEnv {
                      name = "system-applications";
                      paths = config.environment.systemPackages;
                      pathsToLink = "/Applications";
                    }
                  }/Applications -maxdepth 1 -type l -exec readlink '{}' + |
                  while read -r src; do
                    app_name=$(basename "$src")
                    echo "copying $src" >&2
                    ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
                  done
                '';
              };
            };
            defaults = {
              ".GlobalPreferences" = {
                "com.apple.mouse.scaling" = 3.0;
                "com.apple.sound.beep.sound" = "/System/Library/Sounds/Blow.aiff";
              };
              dock = {
                autohide = true;
                autohide-time-modifier = 1.0;
                autohide-delay = 0.0;
                enable-spring-load-actions-on-all-items = true;
                expose-group-by-app = false;
                largesize = 95;
                launchanim = true;
                magnification = true;
                mineffect = "scale";
                minimize-to-application = true;
                mru-spaces = false;
                orientation = "bottom";
                persistent-apps = [ ];
                show-recents = false;
                showhidden = true;
                show-process-indicators = true;
                static-only = true;
                tilesize = 70;
                # Hot corners
                # Possible values:
                #  1: No action
                #  2: Mission Control
                #  3: Show application windows
                #  4: Desktop
                #  5: Start screen saver
                #  6: Disable screen saver
                #  7: Dashboard
                # 10: Put display to sleep
                # 11: Launchpad
                # 12: Notification Center
                # 13: Lock Screen
                # 14: Quick Note
                wvous-tl-corner = 1;
                wvous-tr-corner = 5;
                wvous-bl-corner = 4;
                wvous-br-corner = 14;
              };
              finder = {
                _FXShowPosixPathInTitle = true;
                _FXSortFoldersFirst = true;
                AppleShowAllExtensions = true;
                AppleShowAllFiles = false;
                CreateDesktop = true;
                FXDefaultSearchScope = "SCcf";
                FXEnableExtensionChangeWarning = true;
                FXPreferredViewStyle = "clmv";
                QuitMenuItem = false;
                ShowPathbar = true;
                ShowStatusBar = true;
              };
              LaunchServices = {
                LSQuarantine = false;
              };
              loginwindow = {
                autoLoginUser = null;
                DisableConsoleAccess = true;
                GuestEnabled = false;
                LoginwindowText = "I use Nix btw";
                PowerOffDisabledWhileLoggedIn = false;
                RestartDisabled = false;
                RestartDisabledWhileLoggedIn = false;
                SHOWFULLNAME = false;
                ShutDownDisabled = false;
                ShutDownDisabledWhileLoggedIn = false;
                SleepDisabled = false;
              };
              NSGlobalDomain = {
                "com.apple.mouse.tapBehavior" = 1;
                "com.apple.sound.beep.feedback" = null;
                "com.apple.sound.beep.volume" = 0.7788008;
                "com.apple.swipescrolldirection" = true;
                "com.apple.trackpad.forceClick" = false;
                "com.apple.trackpad.scaling" = 1.0;
                _HIHideMenuBar = true;
                AppleEnableSwipeNavigateWithScrolls = true;
                AppleICUForce24HourTime = true;
                AppleInterfaceStyleSwitchesAutomatically = true;
                AppleScrollerPagingBehavior = true;
                AppleShowScrollBars = "Always";
                KeyRepeat = 1;
                InitialKeyRepeat = 10;
                NSAutomaticWindowAnimationsEnabled = true;
                NSDocumentSaveNewDocumentsToCloud = false;
                NSScrollAnimationEnabled = true;
                NSTableViewDefaultSizeMode = 1;
                NSWindowShouldDragOnGesture = true;
                PMPrintingExpandedStateForPrint = true;
              };
              screencapture = {
                disable-shadow = true;
                location = "~/Desktop";
                show-thumbnail = true;
                type = "png";
              };
              screensaver = {
                askForPassword = true;
                askForPasswordDelay = null;
              };
              SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
              trackpad = {
                ActuationStrength = 1;
                Clicking = true;
                Dragging = false;
                TrackpadRightClick = true;
              };
            };
          };

          nix = {
            package = pkgs.nix;
            useDaemon = true;
            configureBuildUsers = true;
            gc.automatic = true;
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

          security.pam.enableSudoTouchIdAuth = true;
          users.users.morgan.home = "/Users/morgan";
          home-manager.backupFileExtension = "backup";
          nixpkgs = {
            hostPlatform = "aarch64-darwin";
            config.allowUnfree = true;
          };

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
            home-manager.users.morgan = import ./home.nix;
          }
        ];
      };
      darwinPackages = self.darwinConfigurations."concord".pkgs;
    };
}
