{ pkgs, ... }:
let
  # Tower counterpart of the Mac's nix-update: updates the tower's inputs only,
  # applies, then commits and pushes the lock so the Mac stays in sync.
  nix-update = pkgs.writeShellScriptBin "nix-update" ''
    set -euo pipefail
    cd "$HOME/.dotfiles"
    git pull --ff-only
    nix flake update nixpkgs-nixos home-manager-nixos nixpkgs-unstable zen-browser
    sudo nixos-rebuild switch --flake "$HOME/.dotfiles#sanctuary"
    if git diff --quiet -- flake.lock; then
      echo "Already up to date."
    else
      git commit -m "feat(nix): update sanctuary lock" -- flake.lock
      git push
    fi
  '';
in
{
  environment.systemPackages = [ nix-update ];

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
