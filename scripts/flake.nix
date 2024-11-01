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
        pkgs.mkalias
        ];

      homebrew = {
        enable = true;
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;

        # Will remove all the packages that are not in the configuration
        onActivation.cleanup = "zap";

        # Non-cask apps
        brews = [

        ];

        # Cask apps
        casks = [
          
        ];

        # Mac App Store apps
        masApps = {

        };
      };

      # Set up the alias for applications to be indexed by the system.
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in    
      pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';

      system.activationScripts.extraSettings.text = ''
          # See: https://security.stackexchange.com/a/47786/8918
          defaults write com.apple.terminal SecureKeyboardEntry -bool true

          # Remove warning when purging trash
          defaults write com.apple.finder WarnOnEmptyTrash -bool false

          # Avoid creating .DS_Store files on network or USB volumes
          defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
          defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
          
          # Automatically open a new Finder window when a volume is mounted
          defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
          defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
          defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

          # Set Desktop as the default location for new Finder windows
          # For other paths, use `PfLo` and `file:///full/path/here/`
          defaults write com.apple.finder NewWindowTarget -string "PfLo"
          defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"
        '';

      # MacOS default settings
      # Documentation found at: https://mynixos.com/nix-darwin/options/system.defaults
      system = {
        stateVersion = 5;
        configurationRevision = self.rev or self.dirtyRev or null;
        startup.chime = false;
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
            wvous-tl-corner = 2;
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
            LoginwindowText = "Praise the Greater Good!";
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
            AppleShowAllExtensions = true;
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
            askForPasswordDelay = 0;
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
