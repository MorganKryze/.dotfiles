{
  boot.loader = {
    systemd-boot = {
      enable = true;
      # Keep the 1 GB ESP from filling up with old generations
      configurationLimit = 10;
      # No kernel command line editing at boot (would allow init=/bin/sh)
      editor = false;
    };
    efi.canTouchEfiVariables = true;
  };

  # Firmware blobs (Intel AX210 Wi-Fi/Bluetooth, AMD microcode) and firmware
  # updates through `fwupdmgr`.
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;
}
