{ config, pkgs, ... }:

{
  imports = [
    ./user.nix
  ];

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };
}
