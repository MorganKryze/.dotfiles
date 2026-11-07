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

  # French AZERTY, also on the TTY and in SDDM
  services.xserver.xkb.layout = "fr";
  console.useXkbConfig = true;
}
