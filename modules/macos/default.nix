{ ... }:

{
  imports = [
    ./user.nix
    ./system
    ./shell
  ];

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };
}
