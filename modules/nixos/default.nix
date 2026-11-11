# NixOS modules for the Linux tower (`sanctuary`), one file per concern.
# Layout and several settings come from github.com/ripitchip/.dotfiles-nix.
# ponytail: plain imports, no `my.<feature>.enable` options while there is a
# single Linux host; add them (like ripitchip's) when a second one appears.
{
  imports = [
    ./apps.nix
    ./audio.nix
    ./bluetooth.nix
    ./boot.nix
    ./desktop.nix
    ./dual-boot.nix
    ./fonts.nix
    ./gaming.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./nvidia.nix
    ./packages.nix
    ./security.nix
    ./users.nix
    ./vpn.nix
  ];
}
