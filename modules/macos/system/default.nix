{ config, pkgs, ... }:
{
  # MacOS default settings
  # Documentation found at: https://mynixos.com/nix-darwin/options/system.defaults
  system = {
    stateVersion = 5;
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

          echo "Warning: Do not forget to run "brew cleanup" from time to time to remove old versions of installed software" >&2
        '';
      };
    };
    defaults = {
      ".GlobalPreferences" = {
        "com.apple.mouse.scaling" = 3.0;
        "com.apple.sound.beep.sound" = "/System/Library/Sounds/Blow.aiff";
      };
      dock = {
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
        autohide = true;
        autohide-time-modifier = 1.0;
        autohide-delay = 0.0;
        enable-spring-load-actions-on-all-items = true;
        expose-group-apps = false;
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
}
