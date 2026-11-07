{ pkgs, ... }:
let
  # Windows lives on the other SSD with its own ESP, so systemd-boot cannot
  # list it (and could not chainload it under Secure Boot anyway). This sets the
  # firmware's one-shot "next boot" entry instead. F12 at boot also works.
  reboot-windows = pkgs.writeShellScriptBin "reboot-windows" ''
    entry=$(${pkgs.efibootmgr}/bin/efibootmgr | ${pkgs.gawk}/bin/awk '/Windows Boot Manager/ { print substr($1, 5, 4); exit }')
    if [ -z "$entry" ]; then
      echo "No 'Windows Boot Manager' entry in the firmware: use F12 at boot." >&2
      exit 1
    fi
    sudo ${pkgs.efibootmgr}/bin/efibootmgr --bootnext "$entry" >/dev/null && systemctl reboot
  '';
in
{
  # Boot menu: 30 s to choose, NixOS (latest generation) by default.
  boot.loader.timeout = 30;

  # Windows sits on another ESP, which systemd-boot can only reach through the
  # EDK2 UEFI shell. Step 1 (now): list the shell to read the Windows ESP's
  # handle with `map -c`. Step 2: a `boot.loader.systemd-boot.windows` entry
  # with that handle replaces it.
  # ⚠️ The shell is unsigned: the Windows entry will stop working once Secure
  # Boot is on (lanzaboote). F12 and reboot-windows keep working.
  boot.loader.systemd-boot.edk2-uefi-shell.enable = true;

  environment.systemPackages = [
    reboot-windows
    pkgs.efibootmgr
    pkgs.ntfs3g # read the Windows SSD when needed
  ];
}
