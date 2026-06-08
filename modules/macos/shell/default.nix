{ pkgs, ... }:

# Sysadmin baseline: tools that must be on $PATH before Homebrew loads
# and must survive a brew uninstall. Keep this list tight.
# See ../../../docs/packaging.md for the full policy.
{
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    mkalias  # used by the macOS Spotlight activation script (system/default.nix)

    # Networking essentials not shipped (or too old) on stock macOS.
    # curl is provided by Homebrew; .exports puts the brew bin first.
    openssh
    wget
    nmap
    gmp
  ];
}
