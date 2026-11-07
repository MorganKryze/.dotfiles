# NixOS tower (`sanctuary`)

> Gaming tower on NixOS 26.05, dual boot with Windows 11. Same flake as the Mac.

## Hardware

| Part | Model | Notes |
| --- | --- | --- |
| CPU | Ryzen 7 9800X3D | iGPU (Granite Ridge) present but idle |
| GPU | RTX 5070 Ti (MSI Shadow) | Blackwell: open kernel modules only, driver 595.71 |
| Board | Gigabyte B650 Gaming X AX V2 | BIOS F38. `Del` = setup, `F12` = boot menu |
| Wi-Fi / Bluetooth | Intel AX210 | Antenna also needed for Bluetooth range |
| Ethernet | Realtek RTL8125 2.5 GbE | Main connection |
| NixOS disk | WD SN350QE 2 TB | `BOOT` (1 GB, FAT32) + `nixos` (ext4) |
| Windows disk | Acer Predator GM7 1 TB | Windows 11 Pro, its own ESP |
| Screen | ASUS VG34VQL3A, 3440×1440 | 180 Hz needs *Overclocking* on in the screen's menu, VRR needs *VRR* on |

## Layout

```
hosts/sanctuary/default.nix                hostname, stateVersion, imports
hosts/sanctuary/hardware-configuration.nix disks (by label), kernel modules, zram
hosts/sanctuary/home.nix                   Home Manager: cross-platform apps of the Mac + native zsh
modules/nixos/                             one file per concern (boot, nvidia, desktop, gaming, ...)
```

The module layout and several settings come from
[ripitchip/.dotfiles-nix](https://github.com/ripitchip/.dotfiles-nix). There are no `my.*.enable` options while
there is a single Linux host.

`hosts/sanctuary/home.nix` reuses `git`, `starship`, `tmux`, `nushell` and the Ghostty config. It leaves out
`symlinks.nix`: those zsh files source Homebrew paths.

## Daily use

| Task | Command |
| --- | --- |
| Apply local changes | `sudo nixos-rebuild switch --flake ~/.dotfiles#sanctuary` |
| Apply at next boot only | `sudo nixos-rebuild boot --flake ~/.dotfiles#sanctuary` |
| Update inputs | `nix flake update`, then switch |
| Roll back | `sudo nixos-rebuild switch --rollback`, or pick an older generation in the boot menu |
| Deploy from the Mac (untested) | `nix run nixpkgs#nixos-rebuild -- switch --flake .#sanctuary --target-host root@sanctuary --build-host root@sanctuary` |
| Reboot into Windows | `reboot-windows` (or `F12` at boot) |

## Dual boot

- Each OS has its own disk and its own ESP. The firmware boots *Linux Boot Manager* first.
- `reboot-windows` sets the firmware's one-shot `BootNext` to *Windows Boot Manager*. systemd-boot does not list
  Windows: it lives on another ESP, and the EDK2-shell workaround (`boot.loader.systemd-boot.windows`) cannot run
  under Secure Boot.
- The hardware clock is UTC on both sides (`RealTimeIsUniversal` is set in Windows).
- A big Windows update can put *Windows Boot Manager* back first: fix it in the BIOS boot order.
- Do not share a Steam library over NTFS between the two systems.

## Install (2026-11-07)

From the NixOS 26.05 graphical ISO, driven over SSH from the Mac
(`curl -s https://github.com/MorganKryze.keys > ~/.ssh/authorized_keys` on the live session):

```sh
sgdisk --zap-all /dev/<wd>
sgdisk -n1:0:+1G -t1:EF00 -c1:BOOT -n2:0:0 -t2:8300 -c2:nixos /dev/<wd>
mkfs.fat -F32 -n BOOT /dev/<wd>p1
mkfs.ext4 -L nixos /dev/<wd>p2
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot && mount -o fmask=0077,dmask=0077 /dev/disk/by-label/BOOT /mnt/boot
nixos-install --flake path:<dotfiles>#sanctuary --no-root-passwd
nixos-enter --root /mnt -c 'passwd morgan'
```

The Windows install was moved beforehand from the WD to the GM7 (partition table rebuilt with the same GUIDs,
`ntfsclone` per partition). Full log, outside this repo: `~/Desktop/Fallout/notes/dual-boot-windows-nixos.md`.

## Known issues and next steps

- **VS Code** 1.144.0 does not build on nixos-26.05 (2026-11-07: `rm …/@vscode/ripgrep/bin/rg: No such file`).
  It is left out of `modules/nixos/packages.nix` until fixed. `programs.git` still sets `code --wait` as editor.
- **Secure Boot** is off. Anti-cheat games on Windows (Valorant, Battlefield 6, Black Ops 7) need it: plan is
  [lanzaboote](https://github.com/nix-community/lanzaboote) with `sbctl enroll-keys --microsoft`.
- **GitHub from the tower** needs its own SSH key: `programs.git` rewrites HTTPS GitHub URLs to SSH.
- Later, from ripitchip's config: niri as a second session, sops-nix secrets with `users.mutableUsers = false`.
