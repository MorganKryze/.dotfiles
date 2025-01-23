{ pkgs, ... }:

{
  users.users.morgan = {
    home = "/Users/morgan";
    description = "cosplaying as a sysadmin.";
    shell = pkgs.zsh;
  };

  security.pam.enableSudoTouchIdAuth = true;
}
