{ pkgs, inputs, ... }:

{
  nix = {
    package = pkgs.nix;
    useDaemon = true;
    configureBuildUsers = true;
    gc.automatic = true;
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

  networking.hostName = "concord";
}
