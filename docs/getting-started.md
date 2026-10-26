# Getting started

> New to Nix? Read this first. It explains the moving parts of this repo and walks through the changes you will
> make most often.

## The four pieces

| Piece | What it does here |
| --- | --- |
| **Nix** | The package manager. Builds everything into `/nix/store`, read-only, one folder per exact version. |
| **Flake** (`flake.nix` + `flake.lock`) | The entry point. `flake.nix` names the sources (nixpkgs, nix-darwin, …); `flake.lock` pins each one to an exact commit, so the same repo always builds the same system. |
| **nix-darwin** (`modules/macos/`) | Manages macOS itself: system settings, system packages, launchd services, and Homebrew through `nix-homebrew`. |
| **Home Manager** (`modules/home-manager/`) | Manages the user's home folder: dotfiles and user programs. |

You never edit the system directly. You edit this repo, then **apply** it:

```bash
sudo darwin-rebuild switch --flake ~/.dotfiles#concord
```

`concord` is the name of the configuration in `flake.nix` (`darwinConfigurations."concord"`). The switch builds the
new system, then activates it: settings, services, Homebrew packages and home files all change at once. Each switch
creates a **generation** you can roll back to.

## Why editing `~/.zshrc` does nothing

`~/.zshrc`, `~/.aliases` and the other dotfiles are symlinks into `/nix/store`, which is read-only:

```
~/.aliases → /nix/store/…-home-manager-files/.aliases
```

Edit the source in this repo (`modules/home-manager/…`), then switch. The table in
[`symlinks.nix`](../modules/home-manager/symlinks.nix) maps each file in `$HOME` to its source.

## Recipes

### Install a Mac app

1. Find the cask name: `brew search <app>`.
2. Add it to `casks` in [`modules/macos/homebrew.nix`](../modules/macos/homebrew.nix), under the matching category,
   with a one-line comment.
3. Switch.

### Install a command-line tool

Usually a brew formula: add it to `brews` in the same file. If you are not sure where a tool belongs, the
[packaging policy](./packaging.md) decides.

### Remove an app

Delete its line and switch. Homebrew runs with `cleanup = "zap"`, so the app **and its settings** are removed.

> [!WARNING]
> The same rule removes anything installed by hand with `brew install` on the next switch. Always go through
> `homebrew.nix`.

### Add an alias or a shell function

Aliases go in [`shell/.aliases`](../modules/home-manager/shell/.aliases), functions in
[`shell/.functions`](../modules/home-manager/shell/.functions). Switch, then open a new terminal.

### Change a macOS setting

Dock, Finder, keyboard and trackpad settings live in [`modules/macos/system`](../modules/macos/system/default.nix).
The available options are listed on [mynixos.com](https://mynixos.com/nix-darwin/options/system.defaults).

### Update everything

```bash
nix-update
```

This updates `flake.lock` to the latest commits of each source, switches, and cleans Homebrew. Commit the new
`flake.lock` afterwards.

## Checking a change before applying it

```bash
nix build ~/.dotfiles#darwinConfigurations.concord.system
```

This builds the whole system without activating anything. If it fails, the running machine is untouched. Run it
before every switch when you are unsure.

## Undoing a change

| Situation | Command |
| --- | --- |
| The switch worked but the result is wrong | `sudo darwin-rebuild --rollback` |
| See past generations | `darwin-rebuild --list-generations` |
| Go back in the repo too | `git revert <commit>`, then switch |

## Where to go next

- [Packaging policy](./packaging.md): where a tool or config file belongs
- [Upgrading](./upgrading.md): moving to a new nixpkgs release
- [nix-darwin options](https://nix-darwin.github.io/nix-darwin/manual/) and
  [Home Manager options](https://nix-community.github.io/home-manager/options.xhtml)
