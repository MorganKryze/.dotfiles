{ config, ... }:
{
  # RTX 5070 Ti (Blackwell): only the open kernel modules support RTX 50 cards.
  # The screen is plugged into the NVIDIA card; the Ryzen iGPU stays idle.
  services.xserver.videoDrivers = [ "nvidia" ]; # also used under Wayland
  hardware.graphics.enable = true;
  hardware.nvidia = {
    open = true;
    modesetting.enable = true; # required by Wayland compositors
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
