{
  # Realtime scheduling for PipeWire: fewer crackles under load
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # 32-bit games through Proton
    pulse.enable = true;
  };
}
