# Gaming tower: Ryzen 7 9800X3D, Gigabyte B650 Gaming X AX V2, RTX 5070 Ti.
# Written by hand rather than by nixos-generate-config: the install formatted the
# partitions with the labels used below (BOOT, nixos). Checked on 2026-11-07
# against `nixos-generate-config --show-hardware-config`: same kernel modules.
{ lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-amd" ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    # The ESP holds the systemd-boot random seed: keep it private.
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  # 32 GB of RAM: compressed swap in RAM instead of a swap partition
  zramSwap.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
}
