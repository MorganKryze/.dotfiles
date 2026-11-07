{ pkgs, ... }:
let
  # One-shot "next boot" entry in the firmware, to reach Windows without
  # waiting for the menu. F12 at boot also works.
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
  # Windows sits on the GM7 with its own ESP (GPT partition GUID below, read
  # from `sfdisk -d` and the EFI shell's `map` on 2026-11-07). Limine starts its
  # Microsoft-signed boot manager directly, which also works under Secure Boot.
  boot.loader.limine.extraEntries = ''
    /Windows 11
      comment: Windows 11 Pro on the Predator GM7
      protocol: efi
      path: guid(76f7dc86-a54b-4fdb-a286-51ab060e3440):/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  environment.systemPackages = [
    reboot-windows
    pkgs.efibootmgr
    pkgs.ntfs3g # read the Windows SSD when needed
  ];
}
