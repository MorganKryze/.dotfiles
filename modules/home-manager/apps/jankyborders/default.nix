{ pkgs, ... }:

{
  services.jankyborders = {
    enable = true;
    package = pkgs.jankyborders;
    active_color = "0xffe1e3e4";
    inactive_color = "0xff494d64";
    hidpi = true;
    width = 5.0;
  };
}
