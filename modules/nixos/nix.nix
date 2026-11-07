{
  # NVIDIA driver and Steam are unfree
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Let wheel users use extra substituters / build without sudo
      trusted-users = [ "@wheel" ];
    };

    # Flakes only: the registry and NIX_PATH already point at the flake's nixpkgs
    channel.enable = false;

    # Hard-link identical files in the store, weekly
    optimise.automatic = true;

    # Delete old generations and unused store paths, weekly
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
