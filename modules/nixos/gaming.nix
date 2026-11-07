{ pkgs, ... }:
{
  programs.steam = {
    enable = true; # also sets hardware.graphics.enable32Bit
    extraCompatPackages = [ pkgs.proton-ge-bin ]; # GE-Proton: FSR 4 upgrade and game fixes
  };
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  users.users.morgan.extraGroups = [ "gamemode" ];

  environment.systemPackages = with pkgs; [
    mangohud
    # Missing runtimes in a game's Proton prefix, e.g. Fallout 4:
    #   protontricks 377160 vcrun2022 arial
    protontricks
  ];
}
