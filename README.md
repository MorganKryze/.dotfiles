# .dotfiles

> Declarative setup for my Mac (`concord`): nix-darwin + Home Manager + Homebrew, one flake.

![screenshot](./docs/assets/img/presentation.jpg)

## What's inside

| Area | Tools | Where |
| --- | --- | --- |
| System | macOS defaults, Touch ID sudo, Spotlight aliases for Nix apps | `modules/macos/system`, `modules/macos/user.nix` |
| Packages | Homebrew formulae & casks, nix system packages | `modules/macos/homebrew.nix`, `modules/macos/packages.nix` |
| Window management | yabai, skhd, SketchyBar, JankyBorders | `modules/macos/services/` |
| Shell | zsh, starship, nushell, tmux | `modules/home-manager/apps/`, `modules/home-manager/shell/` |
| Terminals | WezTerm, Ghostty | `modules/home-manager/apps/{wezterm,ghostty}` |
| Dev | git (+ emoji commit hooks), VS Code, conda | `modules/home-manager/apps/{git,vscode,conda}` |
| SSH | keychain-backed agent loaded at login | `modules/macos/services/ssh-add-keychain` |

## Layout

```
flake.nix                  inputs (nixpkgs / nix-darwin / home-manager 26.05, nix-homebrew)
hosts/concord/             host-specific settings
modules/macos/             nix-darwin: system, packages, Homebrew, launchd services
modules/home-manager/      user config: HM programs + raw symlinks (symlinks.nix)
dependencies/bash-toolbox/ submodule: logging helpers used by the shell scripts
scripts/bootstrap.sh       first-install script
docs/                      policies and runbooks
```

## Install

Requirements: Apple Silicon Mac on macOS 26 (Tahoe), internet access.

```bash
curl -s https://raw.githubusercontent.com/MorganKryze/.dotfiles/main/scripts/bootstrap.sh | zsh
```

The script sets the hostname, installs the Xcode CLT, Rosetta and Nix, clones this repo to `~/.dotfiles`, then
runs the first `darwin-rebuild switch`. It stops after installing Nix: open a new terminal and run it again.

### After the first switch

1. Open the Objective-See apps (LuLu, BlockBlock, …) and grant their permissions.
2. Open the other apps once to sign in and configure them.
3. Once Bitwarden and the browser are set up, create the Git SSH connections: `create-git-ssh-connections`.
4. Start the window manager and grant its permissions: `yabai-start`.

## Daily use

| Task | Command |
| --- | --- |
| Update inputs and apply | `nix-update` |
| Apply local changes only | `sudo darwin-rebuild switch --flake ~/.dotfiles#concord --impure` |
| Check a change builds, without activating | `nix build ~/.dotfiles#darwinConfigurations.concord.system --impure` |
| Roll back | `sudo darwin-rebuild --rollback` |

> [!WARNING]
> Homebrew runs with `cleanup = "zap"`: anything installed by hand with `brew install` is removed on the next
> switch. Add it to `modules/macos/homebrew.nix` instead.

## Docs

- [Packaging policy](./docs/packaging.md): where a tool or a config file should live, and why
- [Upgrading](./docs/upgrading.md): bumping the nix base release, and the pitfalls hit so far
- [SSH agent & keychain](./docs/ssh-agent.md): the stale-socket trap, and what survives a reboot

## Credits

Started from [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) and supersedes my earlier
[Easy-Git](https://github.com/MorganKryze/easy-git), [Easy-Env](https://github.com/MorganKryze/easy-env),
[Yabai-Setup](https://github.com/MorganKryze/yabai-setup) and [Mac-Setup](https://github.com/MorganKryze/mac-setup).
Third-party licences are in [ACKNOWLEDGMENTS](./.github/ACKNOWLEDGMENTS.md).

## License

MIT, see [LICENSE](LICENSE.md).
