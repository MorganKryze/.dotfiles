{ pkgs, ... }:
{
  # Limine rather than systemd-boot: a themable graphical menu, Windows started
  # directly from its own ESP (see dual-boot.nix), and built-in Secure Boot
  # signing through sbctl (boot.loader.limine.secureBoot) for anti-cheat games.
  boot.loader = {
    limine = {
      enable = true;
      # Rollback points shown at boot; older generations stay usable with
      # `nixos-rebuild switch --rollback` until the weekly GC (14 days).
      maxGenerations = 3;
      style = {
        wallpapers = [ pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath ];
        interface.branding = "sanctuary";
      };
    };
    # 30 s to choose; the latest NixOS generation boots by default
    timeout = 30;
    efi.canTouchEfiVariables = true;
  };

  # Firmware blobs (Intel AX210 Wi-Fi/Bluetooth, AMD microcode) and firmware
  # updates through `fwupdmgr`.
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;
}
