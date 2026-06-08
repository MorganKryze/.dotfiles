{ pkgs, ... }:

{
  services.jankyborders = {
    enable = true;
    package = pkgs.jankyborders;
    active_color = "0xc0e2e2e3";
    inactive_color = "0xc02c2e34";
    background_color = "0x302c2e34";
    hidpi = true;
    width = 6.0;
    style = "round";
  };
}
