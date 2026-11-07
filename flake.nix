{
  description = "Concord (Mac) and Sanctuary (NixOS tower) configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # The darwin branch only builds for macOS: the Linux tower follows NixOS's own.
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      nixpkgs-nixos,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
          # nix-darwin 25.11 requires this for user-level `system.defaults.*`
          # (Dock/Finder/trackpad/etc.) options to apply.
          system.primaryUser = "morgan";
          nix = {
            package = pkgs.nix;
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
              # Tap trust is declared on homebrew.taps (modules/macos/homebrew.nix).
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
          ./modules/macos
          ./hosts/concord
        ];
      };
      darwinPackages = self.darwinConfigurations."concord".pkgs;

      # Gaming tower (Ryzen 7 9800X3D, RTX 5070 Ti), dual boot with Windows.
      nixosConfigurations."sanctuary" = nixpkgs-nixos.lib.nixosSystem {
        modules = [
          { system.configurationRevision = self.rev or self.dirtyRev or null; }
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.morgan = import ./hosts/sanctuary/home.nix;
              backupFileExtension = "backup";
            };
          }
          ./hosts/sanctuary
        ];
      };
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt;
      formatter.x86_64-linux = nixpkgs-nixos.legacyPackages.x86_64-linux.nixfmt;
    };
}
