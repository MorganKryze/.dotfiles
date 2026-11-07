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

## Apps and tools

| What | Where |
| --- | --- |
| VS Code, Claude Code (from `nixpkgs-unstable`), Bitwarden, LocalSend, Discord, Signal, LibreOffice, OBS, mpv, Jellyfin, FreeCAD, OrcaSlicer, Docker + lazydocker | `modules/nixos/apps.nix` |
| Ollama with CUDA, built locally for `sm_120` only (unfree, not cached), API on `localhost:11434` | `modules/nixos/apps.nix` |
| Lutris (Battle.net, GE-Proton runner), Modrinth | `modules/nixos/gaming.nix` |
| Zen (flake `0xc000022070/zen-browser-flake`, default browser) | `hosts/sanctuary/home.nix` |
| Hack and Symbols Nerd Fonts | `modules/nixos/fonts.nix` |
| lynis (`sudo lynis audit system`), ClamAV (`clamscan -r <dir>`, signatures updated daily, no daemon) | `modules/nixos/security.nix` |
| CLI tools mirroring the Mac's brews, zsh with the Mac's `.aliases` / `.functions` / `.git_func` | `hosts/sanctuary/home.nix` |

macOS-only aliases and functions are wrapped in `if [[ "$OSTYPE" == darwin* ]]` in the shared shell files, with
Linux equivalents where useful (`localip`, `ips`, `stfu`, `pumpitup`).

Desktop extras, set once by hand (no plasma-manager yet):

- **Launcher (Raycast-like):** Vicinae runs as a user service. Bind it in System Settings > Keyboard > Shortcuts >
  Add New > Command or Script: `vicinae toggle`, for instance on `Meta+Space`. KRunner stays on `Alt+Space`.
- **Tiling (yabai-like):** Krohnkite, enabled in System Settings > Window Management > KWin Scripts.
- Discover is removed: it cannot install NixOS packages.

## Daily use

| Task | Command |
| --- | --- |
| Apply local changes | `sudo nixos-rebuild switch --flake ~/.dotfiles#sanctuary` |
| Apply at next boot only | `sudo nixos-rebuild boot --flake ~/.dotfiles#sanctuary` |
| Update the tower | `nix-update`: pulls, updates `nixpkgs-nixos`, `home-manager-nixos`, `nixpkgs-unstable` and `zen-browser` only, switches, commits and pushes `flake.lock` |
| Roll back | `sudo nixos-rebuild switch --rollback`, or pick an older generation in the boot menu (last 3) |
| Deploy from the Mac (untested) | `nix run nixpkgs#nixos-rebuild -- switch --flake .#sanctuary --target-host root@sanctuary --build-host root@sanctuary` |
| Reboot into Windows | pick *Windows 11* in the boot menu, or `reboot-windows`, or `F12` at boot |

## Updates: each machine owns its inputs

The Mac uses `nixpkgs`, `nix-darwin`, `home-manager` and `nix-homebrew`; the tower uses `nixpkgs-nixos`,
`home-manager-nixos`, `nixpkgs-unstable` (VS Code, Claude Code) and `zen-browser`. Each `nix-update` only bumps its own machine's inputs, so neither machine ever receives
versions it has not built itself, and both can update independently. Never run a bare `nix flake update`: it
bumps both sides at once. Pull before editing on the other machine.

## Dual boot

- Each OS has its own disk and its own ESP. The firmware boots **Limine** first (WD ESP).
- Limine menu: 30 s, the latest NixOS generation by default, the last 3 generations as rollback points, then
  *Windows 11*. Limine starts Windows' boot manager straight from the GM7's ESP, by GPT partition GUID
  (`modules/nixos/dual-boot.nix`), so the entry keeps working under Secure Boot.
- `reboot-windows` sets the firmware's one-shot `BootNext` to *Windows Boot Manager*. `F12` at boot also works.
- The hardware clock is UTC on both sides (`RealTimeIsUniversal` is set in Windows).
- A big Windows update can put *Windows Boot Manager* back first: fix it in the BIOS boot order.
- Do not share a Steam library over NTFS between the two systems.
- History: systemd-boot came first (2026-11-07). It cannot list a Windows install on another ESP except through
  the unsigned EDK2 shell (`boot.loader.systemd-boot.windows`), which breaks under Secure Boot, and it has no
  theming. Its files (`/boot/EFI/systemd`, `/boot/loader`) and the *Linux Boot Manager* firmware entry are kept
  as a fallback until Limine has proven itself.

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

- **VS Code** 1.144.0 does not build on nixos-26.05 (2026-11-07: `rm …/@vscode/ripgrep/bin/rg: No such file`), so
  it comes from `nixpkgs-unstable`. Move it back to the stable channel once fixed there.
- **Secure Boot** is off. Anti-cheat games on Windows (Valorant, Battlefield 6, Black Ops 7) need it: plan is
  `boot.loader.limine.secureBoot` (Limine signed with sbctl), keys enrolled with `--microsoft` for Windows and
  the GPU's option ROM.
- **Old systemd-boot files** on the ESP: remove `/boot/EFI/systemd`, `/boot/loader` and the *Linux Boot Manager*
  firmware entry once Limine has booted fine for a while.
- **GitHub from the tower** needs its own SSH key: `programs.git` rewrites HTTPS GitHub URLs to SSH.
- Later, from ripitchip's config: niri as a second session, sops-nix secrets with `users.mutableUsers = false`.
