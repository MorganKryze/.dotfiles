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

## Updating this doc

When you add a new tool, check this file first. When you _move_ a tool
between sources, update the relevant comment headers in
`packages.nix` / `homebrew.nix` / `shell/default.nix` if your reason
clarifies a rule that wasn't obvious here.
