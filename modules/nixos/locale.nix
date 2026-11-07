{
  # The hardware clock stays in UTC; Windows reads it the same way through the
  # RealTimeIsUniversal registry key set on its side.
  time.timeZone = "Europe/Paris";

  # English system like the Mac, French formats
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # French AZERTY, also on the TTY and in SDDM. US as a second layout for games
  # that bind keys by letter (Unreal Engine): switch to it and ZQSD acts as WASD.
  # KDE uses this when its own layout list is off (System Settings > Keyboard);
  # switch with KDE's "Switch to Next Keyboard Layout" shortcut (Meta+Alt+K).
  # Proton games only follow the switch with Wine's Wayland driver: launch option
  # `PROTON_ENABLE_WAYLAND=1 %command%`. Through XWayland they always see fr.
  services.xserver.xkb.layout = "fr,us";
  console.useXkbConfig = true;
}
