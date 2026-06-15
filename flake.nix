{
  description = "Concord configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
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
          (
            { config, ... }:
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = true;
                user = "morgan";
                # Homebrew 6+ refuses to load formulae/casks from non-official
                # taps unless they are trusted. Mirror the taps declared in
                # modules/macos/homebrew.nix so trust stays in sync automatically.
                # See https://docs.brew.sh/Tap-Trust.
                trust.taps = map (t: t.name) config.homebrew.taps;
              };
            }
          )
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
    };
}
