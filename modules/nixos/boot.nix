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
      # Retro Pip-Boy look: Fallout 4 wallpapers (3440x1440, CRT scanlines baked
      # in, one picked at random on each boot), monochrome Pip-Boy green
      # (#1AFF80) over a dark green veil.
      style = {
        wallpapers = [
          ./assets/boot-wallpaper-church.jpg
          ./assets/boot-wallpaper-garage.jpg
          ./assets/boot-wallpaper-helmet.jpg
        ];
        interface = {
          branding = "SANCTUARY";
          brandingColor = "1AFF80";
          helpColor = "0F9F50";
          helpColorBright = "1AFF80";
        };
        graphicalTerminal = {
          foreground = "1AFF80"; # text; the selected entry is drawn inverted
          brightForeground = "B8FFD8";
          background = "60001408"; # TTRRGGBB: dark green at ~60% opacity
          brightBackground = "0A3A20";
          # black, red, green, brown, blue, magenta, cyan, gray: all green
          palette = "000000;1AFF80;1AFF80;0F9F50;1AFF80;1AFF80;1AFF80;1AFF80";
          brightPalette = "0A3A20;5CFFA8;5CFFA8;5CFFA8;5CFFA8;5CFFA8;5CFFA8;B8FFD8";
          # Veil over the whole screen, no lighter frame around it
          margin = 0;
          marginGradient = 0;
        };
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
