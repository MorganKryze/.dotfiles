# Gaming tower: Ryzen 7 9800X3D, RTX 5070 Ti, NixOS on the WD 2 TB next to
# Windows 11 on the Predator GM7 1 TB. See docs/nixos.md.
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "sanctuary";

  # Set to the NixOS release at install time, then never change it
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "26.05";
}
