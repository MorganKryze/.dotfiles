{
  description = "Concord configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      security.pam.enableSudoTouchIdAuth = true;

      environment.systemPackages = [ 
        # App aliases
        pkgs.mkalias

        # Core utilities
        pkgs.openssh
        pkgs.nmap
        pkgs.gmp
        pkgs.curl
        pkgs.wget

        # Terminal
        pkgs.gitflow
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
          "mailsy"

          # Langs
          "php"
          "pnpm"
          "openjdk"
          "gradle"

          # Terminal
          "neofetch"
          "htop"
          "btop"
          "lsd"
          "z"

          # Dockers
          "lazydocker"
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
        ];

        # Cask apps
        casks = [
          # Docker
          "docker"

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
          "veracrypt"
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
          "warp"

          # Productivity
          "notion"
          "raycast"
          "maccy"
          "cheatsheet"
          "libreoffice"

          # 3D & Design
          "autodesk-fusion"
          "orcaslicer"
          "lycheeslicer"
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
          "thunderbird"
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

          # Games & Emulators
          "steam"
          "crossover"
          "whisky"
          "battle-net"
          "modrinth"
        ];

        # Mac App Store apps
        masApps = {

        };
      };

      
      # MacOS default settings
      # Documentation found at: https://mynixos.com/nix-darwin/options/system.defaults
      system = {
        stateVersion = 5;
        configurationRevision = self.rev or self.dirtyRev or null;
        startup.chime = false;
        activationScripts = {
          # Set up the alias for applications to be indexed by the system.
          applications = {
            text = ''
              echo "setting up /Applications..." >&2
              rm -rf /Applications/Nix\ Apps
              mkdir -p /Applications/Nix\ Apps
              find ${pkgs.buildEnv { name = "system-applications"; paths = config.environment.systemPackages; pathsToLink = "/Applications"; }}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
              while read src; do
                app_name=$(basename "$src")
                echo "copying $src" >&2
                ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
              done
            '';
          };
          # Ensure Rosetta installation
          extraActivation = {
            text = ''
              softwareupdate --install-rosetta --agree-to-license
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
            largesize = 80;
            launchanim = true;
            magnification = true;
            mineffect = "scale";
            minimize-to-application = true;
            mru-spaces = false;
            orientation = "bottom";
            persistent-apps = [];
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
            LoginwindowText = "";
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

      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config .allowUnfree = true;
      };

      nix = {
        package = pkgs.nix;
        gc.automatic = true;
        optimise.automatic = true;
        settings = {
          auto-optimise-store = true;
          experimental-features = [ "nix-command" "flakes" ];
        };
        extraOptions = ''
          extra-platforms = x86_64-darwin aarch64-darwin
        '';
      };

      services = {
        nix-daemon = {
          enable = true;
        };
      };

      programs = {
        zsh = {
          enable = true;
        };
      };
    };
  in
  {
    darwinConfigurations."concord" = nix-darwin.lib.darwinSystem {
      modules = [ configuration 
      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          enable = true;
          enableRosetta = true;
          user = "morgan";
        };
      }
      ];
    };
    darwinPackages = self.darwinConfigurations."concord".pkgs;
  };
}
