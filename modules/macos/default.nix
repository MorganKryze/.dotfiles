{ config, pkgs, ... }:

{
  imports = [
    ./user.nix
    ./system/settings.nix
  ];

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };
}
