# Upgrading the nix base release

> How to move `nixpkgs` / `nix-darwin` / `home-manager` to a new release (e.g. 26.05 → 26.11) without breaking the
> machine, and the pitfalls already hit on past bumps.

## Release history

| Date | Base | macOS | Notes |
| --- | --- | --- | --- |
| 2026-05-30 | 24.11 → 25.11 | 26.5 Tahoe | Removed all temporary Homebrew scaffolding (brew pin, loader patch). Many renamed options, see below. |
| 2026-09-24 | 25.11 → 26.05 | 26.x Tahoe | Inputs only, plus dropping `--force-cleanup` from the brew bundle flags. |

## Playbook

### 1. Pre-flight

- Read the release notes of [nix-darwin](https://github.com/nix-darwin/nix-darwin) and
  [home-manager](https://nix-community.github.io/home-manager/release-notes.xhtml) for the target release.
- Check the target supports the current macOS version.
- Leave `stateVersion` alone (`system.stateVersion = 5`, `home.stateVersion = "24.11"`): it records the release the
  machine was first installed with, not the current one.

### 2. Bump the inputs

In `flake.nix`, change the three release branches together: `nixpkgs-XX.YY-darwin`, `nix-darwin-XX.YY`,
`release-XX.YY`. `nix-homebrew` follows its default branch and needs no change.

### 3. Re-lock and build without activating

```bash
nix flake update
nix build .#darwinConfigurations.concord.system
```

This is the gate. Every hard error (renamed option, removed package, conflicting file) shows up here, before anything
touches the running system. Fix and rebuild until it passes.

### 4. Activate

Close long-running terminal sessions first: activation upgrades Homebrew packages, zaps unlisted ones and restarts the
launchd services (yabai, skhd, SketchyBar).

```bash
nix-update   # flake update + sudo darwin-rebuild switch + brew cleanup
```

`nix-update` ends with a warning, not an error, when a single cask fails to install: the system config still activated.
Skim the output for a real nix error above it.

### 5. Roll back if needed

- Config: `git restore flake.nix flake.lock`, or revert the commit.
- System: `sudo darwin-rebuild --rollback`, or pick an earlier generation.

## Pitfalls already hit

### Activation

- **Activation runs as root** (since 25.11). Plain `darwin-rebuild switch` fails with *"system activation must now be
  run as root"*. Use `sudo "$(command -v darwin-rebuild)" switch …`; `sudo`'s `secure_path` may not include
  `/run/current-system/sw/bin`.
- **`system.primaryUser = "morgan"`** is required for user-level `system.defaults.*` (Dock, Finder, trackpad).

### Renamed or removed options (24.11 → 25.11)

| Before | After | File |
| --- | --- | --- |
| `services.nix-daemon.enable`, `nix.useDaemon`, `nix.configureBuildUsers` | removed | `flake.nix` |
| `security.pam.enableSudoTouchIdAuth` | `security.pam.services.sudo_local.touchIdAuth` | `modules/macos/user.nix` |
| `environment.pathsToLink = "/Applications"` | `[ "/Applications" ]` (must be a list) | `modules/macos/system/default.nix` |
| `programs.zsh` (home-manager) | disabled: it collides with the symlinked rc files (*"Conflicting managed target files"*) | `modules/home-manager/apps/zsh/default.nix` |
| `thefuck` | removed from nixpkgs | — |

### Homebrew

- **Tap trust** (Homebrew 6+): formulae and casks from non-official taps are refused unless trusted. Trust is
  declared with `trusted = true` on every entry of `homebrew.taps`, so a new tap only needs adding to the list in
  `homebrew.nix`. Do **not** rely on `nix-homebrew.trust.taps` alone: `brew bundle --force-cleanup` rewrites the trust
  store from the Brewfile on every switch, wiping any trust the Brewfile doesn't declare. Activation still works, but
  afterwards plain `brew` commands refuse the taps (*"Refusing to load … from untrusted tap"*).
- **Casks installed outside brew won't adopt** when the app in `/Applications` is older than the cask
  (*"bundle short version … is X but is Y"*). One-time fix: `brew install --cask --force <name>`.
  Do **not** drop the cask from `homebrew.nix` instead: `cleanup = "zap"` would uninstall the app.
- **`mas` 7 breaks `brew bundle`**: every `masApps` entry fails with *"mas installation failed"*, even for installed
  apps. `masApps` stays empty until the interop is fixed; installed App Store apps are not removed.
- **Renamed casks** break the bundle until updated in `homebrew.nix` (e.g. `ledger-live` → `ledger-wallet`).

### Nix paths

- A `home.file.<name>.source` must be a path **relative to the flake** (`../../docs/assets/.hushlogin`). An absolute
  path (`/Users/morgan/…`) fails the whole evaluation: *"access to absolute path '/Users' is forbidden in pure
  evaluation mode"*. Absolute paths inside quoted strings are fine.
