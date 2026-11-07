{ pkgs, ... }:
{
  # KDE Plasma 6 on Wayland: VRR, 180 Hz and NVIDIA work without extra setup.
  # ponytail: niri (as in ripitchip's config) can come later as a second session.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  # Discover cannot install NixOS packages: anything added through it would live
  # outside the dotfiles.
  environment.plasma6.excludePackages = [ pkgs.kdePackages.discover ];

  # Krohnkite: automatic tiling like yabai, as a KWin script. Off until enabled
  # in System Settings > Window Management > KWin Scripts.
  environment.systemPackages = [ pkgs.kdePackages.krohnkite ];

  programs.firefox.enable = true;
}
