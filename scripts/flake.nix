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
      # MacOS default settings
      system = {
        stateVersion = 5;
        configurationRevision = self.rev or self.dirtyRev or null;
        defaults = {
          dock.autohide = true;

        };
      };

      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config .allowUnfree = true;
      }

      nix = {
        package = pkgs.nix;
        gc.automatic = true;
        optimise.automatic = true;
        settings = {
          auto-optimise-store = true;
          experimental-features = [ "nix-command" "flakes" ];
        };
      };

      services = {
        nix-daemon = {
          enable = true;
          socketActivation = true;
          extraOptions = ''
            --max-jobs 4
          '';
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
