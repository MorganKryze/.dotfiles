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

          home-manager.backupFileExtension = "backup";
          system.configurationRevision = self.rev or self.dirtyRev or null;
          services.nix-daemon.enable = true;
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
