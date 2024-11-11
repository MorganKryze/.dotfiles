{ config, pkgs, ... }:

{
  users.users.morgan = {
    home = "/Users/morgan";
    description = "GrosBg";
    shell = pkgs.zsh;
  };

  security.pam.enableSudoTouchIdAuth = true;
}
