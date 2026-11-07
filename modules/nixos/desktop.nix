{
  # KDE Plasma 6 on Wayland: VRR, 180 Hz and NVIDIA work without extra setup.
  # ponytail: niri (as in ripitchip's config) can come later as a second session.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  programs.firefox.enable = true;
}
