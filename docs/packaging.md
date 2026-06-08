# Packaging policy

> Where each tool / app should live, and why. Keep this short — it is the
> tiebreaker when the same binary could plausibly come from two sources.

This repo can install software from four places:

1. **`modules/macos/shell/default.nix`** — `environment.systemPackages`
   for the **minimum** sysadmin baseline.
2. **`modules/macos/packages.nix`** — `environment.systemPackages` for
   everything else nix-managed at the system level.
3. **`modules/macos/homebrew.nix`** — Homebrew formulae and casks.
4. **`modules/home-manager/apps/*/default.nix`** — Home‑Manager
   `programs.<x>` modules (user-scoped, declarative dotfiles).

## The rule (one source per tool)

A tool lives in **exactly one** of the four sources. If you find it in
two, delete from the lower-priority one per the table below.

| Category                              | Goes in                                 | Why |
|---------------------------------------|-----------------------------------------|-----|
| Sysadmin baseline (`openssh`, `nmap`, `wget`, `gmp`, `mkalias`) | `modules/macos/shell/default.nix` | Must work before Homebrew is on `$PATH` and survive a brew uninstall. |
| Tool with a Home-Manager `programs.*` module that we enable (`starship`, `nushell`, `tmux`, `git`, …) | `modules/home-manager/apps/<name>/` | The HM module installs the binary as a dependency. Listing it again in `packages.nix` is redundant. |
| GUI apps (`.app` bundles)             | `modules/macos/homebrew.nix` (casks)     | Casks handle macOS app bundles, code signing, and `/Applications` placement properly. |
| CLI dev tools where we want the latest upstream release fast (`cmake`, `pkg-config`, `fd`, `ripgrep`, `gh`, `jq`, `fzf`, language runtimes, …) | `modules/macos/homebrew.nix` (brews) | Brew tracks upstream within hours; nixpkgs branches lag. |
| Mac App Store apps                    | `modules/macos/homebrew.nix` (`masApps`) | `mas` is the only integration we have. |
| Anything else nix-managed at system scope (utilities we configure declaratively, build-time deps for nix-derived configs, …) | `modules/macos/packages.nix` | Default landing spot for system packages that don't fit a category above. |

## Decision flow

```
Is it a macOS GUI app (.app)?           → homebrew.nix (casks)
Is there an HM programs.* module we use? → modules/home-manager/apps/<name>/
Is it in the sysadmin baseline?          → modules/macos/shell/default.nix
Do we want the upstream-fastest CLI?     → homebrew.nix (brews)
Otherwise                                → modules/macos/packages.nix
```

## When in doubt

Prefer **Homebrew for CLI tools and apps** and **nix for system glue and
HM-managed programs**. Homebrew + nix-darwin already coexist here via
`nix-homebrew`, so there is no “purity” argument for forcing everything
into nix.

## Configs (where does a config file live?)

A separate but related question: once a tool is installed, where does
its config live? Two sources:

1. **Home‑Manager `programs.<x>` module** under
   `modules/home-manager/apps/<name>/default.nix` — the config is
   expressed in nix (or routed through `builtins.fromTOML`/`readFile`)
   and HM owns the file on disk.
2. **Raw symlink** via `modules/home-manager/symlinks.nix` — the file
   in this repo is `home.file`-linked into `$HOME` verbatim.

### Rule

Use the HM `programs.*` module **only when it adds real value**:
type checking, generated includes, secret interpolation, or absorbing
a config the tool itself can't reload without HM's help. Otherwise the
raw symlink is fewer moving parts and easier to edit.

| Config | Source | Why |
|---|---|---|
| `git` (`programs.git`) | HM module | `includes`/`includeIf` and `lfs` are natively supported; type checking is real. |
| `starship` (`programs.starship`) | HM module | We already enable the module for shell integration. `settings = fromTOML (readFile ./starship.toml)` keeps the TOML editable and avoids the dual-ownership of zsh-style. |
| `zsh` (`.zshrc`, `.zshenv`, `.zprofile`) | Raw symlink | Hand-written rc files, brew-installed plugins. `programs.zsh` is **off** — enabling it would clash with the symlinks (`Conflicting managed target files` since HM 25.11). |
| Shell helpers (`.exports`, `.aliases`, `.functions`, `*_func`) | Raw symlink | No HM module exists. |
| `vscode`, `ghostty`, `wezterm`, `fastfetch`, `curl`, `conda`, `superfile`, gitemojis hooks | Raw symlink | No HM module exists, or the module is a passthrough (e.g. `programs.wezterm.extraConfig` just emits the Lua you give it). |

### Decision flow

```
Does an HM programs.* module support what we need declaratively
(includes, type checking, secret interpolation, integration with
another HM module)?
  yes → modules/home-manager/apps/<name>/default.nix
  no  → modules/home-manager/symlinks.nix
```

## Updating this doc

When you add a new tool or config, check this file first. When you
_move_ a tool / config between sources, update the relevant comment
headers in the affected files if your reason clarifies a rule that
wasn't obvious here.
