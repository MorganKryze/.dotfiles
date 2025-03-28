{ pkgs, ... }:

{
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # Move window to prev and next space
      ctrl + alt - p : yabai -m window --space prev;
      ctrl + alt - n : yabai -m window --space next;

      # Move window to space
      shift + alt - 1 : yabai -m window --space 1;
      shift + alt - 2 : yabai -m window --space 2;
      shift + alt - 3 : yabai -m window --space 3;
      shift + alt - 4 : yabai -m window --space 4;
      shift + alt - 5 : yabai -m window --space 5;
      shift + alt - 6 : yabai -m window --space 6;
      shift + alt - 7 : yabai -m window --space 7;

      # Move window and split
      ctrl + alt - down : yabai -m window --warp south
      ctrl + alt - up : yabai -m window --warp north
      ctrl + alt - left : yabai -m window --warp west
      ctrl + alt - right : yabai -m window --warp east

      # Open Apps
      # TODO: Add apps to open
    '';

  };

}
