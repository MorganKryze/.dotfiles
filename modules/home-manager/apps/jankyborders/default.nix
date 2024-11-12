{ pkgs, ... }:

{
  services.jankyborders = {
    enable = true;
    package = pkgs.jankyborders;
  };
}
