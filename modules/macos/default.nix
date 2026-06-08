{ ... }:

{
  imports = [
    ./user.nix
    ./system
    ./shell
    ./packages.nix
    ./homebrew.nix
    ./services
  ];

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };
}
