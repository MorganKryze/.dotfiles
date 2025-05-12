{
  description = "Concord configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew/4945f477bc346d6cd432c67642621f33e6a9b201";
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
        { pkgs, ... }:
        {
          services.nix-daemon.enable = true;
          system.configurationRevision = self.rev or self.dirtyRev or null;
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
            settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
            extraOptions = ''
              extra-platforms = x86_64-darwin aarch64-darwin
            '';
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
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.morgan = import ./modules/home-manager;
              backupFileExtension = "backup";
            };
          }
          ./modules/home-manager/apps/pkgs.nix
          ./modules/home-manager/apps/brew.nix
          ./modules/home-manager/apps/skhd
          ./modules/home-manager/apps/yabai
          ./modules/home-manager/apps/sketchybar
          ./modules/home-manager/apps/jankyborders
          ./modules/macos
          ./hosts/concord
        ];
      };
      darwinPackages = self.darwinConfigurations."concord".pkgs;
    };
}
