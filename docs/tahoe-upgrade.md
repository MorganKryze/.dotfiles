# Homebrew workarounds & the macOS Tahoe / nix-base upgrade

> [!IMPORTANT]
> **✅ DONE — base bumped to 25.11 on 2026-05-30 (macOS 26.5 Tahoe).**
> The temporary brew scaffolding described below has been **removed**; brew is now
> current (5.1.11 on Ruby 4.0) via the default `nix-homebrew`. The treadmill is
> gone. The sections below are kept as the historical record + the migration log.
> See **[Migration log](#migration-log-241125112026-05-30)** for what actually
> changed.

This document originally explained the **temporary** Homebrew scaffolding in
`flake.nix` (now removed), why it existed, and what to change when upgrading to
**macOS 26 (Tahoe)** — so the system wouldn't break.

> [!NOTE]
> The planning sections were written on **macOS 15.7.4 (Sequoia)** / base
> **24.11**. The bump itself was executed on **macOS 26.5 / base 24.11 → 25.11**.

## Migration log (24.11 → 25.11, 2026-05-30)

Executed on macOS 26.5 Tahoe, Apple Silicon. Target **25.11** (mature, supports
Tahoe, has `ruby_4_0`). Each change below was forced by a hard error caught during
`darwin-rebuild build` (dry) before any activation.

| Change | File | Reason (25.11) |
| --- | --- | --- |
| inputs → `nixpkgs-25.11-darwin`, `nix-darwin-25.11`, `release-25.11`, `nix-homebrew` latest | `flake.nix` | the bump itself; brew is now 5.1.11 / Ruby 4.0 |
| removed `brew-src` pin, the `api/cask.rb` patch module, nix-homebrew rev pin | `flake.nix` | scaffolding no longer needed |
| removed `services.nix-daemon.enable`, `nix.useDaemon`, `nix.configureBuildUsers` | `flake.nix` | options removed in newer nix-darwin |
| added `system.primaryUser = "morgan"` | `flake.nix` | now required for user-level `system.defaults.*` |
| `security.pam.enableSudoTouchIdAuth` → `security.pam.services.sudo_local.touchIdAuth` | `modules/macos/user.nix` | renamed |
| `pathsToLink = "/Applications"` → `[ "/Applications" ]` | `modules/macos/system/default.nix` | now strictly a list |
| disabled `programs.zsh` | `apps/zsh/default.nix` | collided with the symlinked `.zshrc`/`.zshenv` (home-manager 25.11 forbids overlap); behavior preserved (plugins come from brew + `.zshrc`) |
| removed `thefuck` (pkg + `.zprofile` eval) | `apps/pkgs.nix`, `apps/zsh/.zprofile` | removed from nixpkgs 25.11 |
| `darwin-rebuild switch` → **`sudo` …** | `shell/.functions` (`nix-update`) | **25.11 requires activation to run as root** |

### Gotchas worth remembering

- **Activation must run as root now.** `darwin-rebuild switch` fails with
  *"system activation must now be run as root"*. Use
  `sudo darwin-rebuild switch --flake ~/.dotfiles#concord --impure` (or
  `sudo $(command -v darwin-rebuild) switch …` if sudo's PATH lacks it).
  `nix-update` was updated accordingly.
- **Casks installed outside brew won't adopt** if their `/Applications` version is
  older than the cask (`bundle short version … is X but is Y`). One-time fix:
  `brew install --cask --force <name>` (overwrites + creates a brew receipt).
  Did this for balenaetcher, knockknock, lulu, libreoffice, inkscape.
- **`mas` 7.0.0 breaks Homebrew Bundle.** The mas rewrite is incompatible with
  brew bundle's mas integration, so **every** `masApps` entry errors with
  *"Unable to install \<app\> app. mas installation failed."* even when the app is
  already installed. `masApps` was disabled entirely (apps stay installed — bundle
  never uninstalls mas apps). Re-enable once mas/brew-bundle interop is fixed.
- **`ledger-live` cask renamed to `ledger-wallet`** upstream.

## TL;DR

- **Everything Homebrew-related added to `flake.nix` is temporary scaffolding for
  the 24.11 base. Nothing is permanent.** The goal is to eventually delete all of
  it and let `nix-homebrew` track current brew.
- The single root constraint is the **24.11 base** (it caps Ruby at 3.4, which
  caps brew at 5.0.0, which has a cask-loader bug that the patch fixes).
- **Updating macOS does not, by itself, break the brew fix** — brew 5.0.0
  supports macOS **14–26**, so it works on Tahoe. What a Tahoe jump pressures is
  the **nix base** (a separate axis).
- Decision taken: **couple the base bump to the Tahoe update** — do it as one
  coordinated upgrade and remove all the scaffolding then.

## Why the scaffolding exists (the dependency chain)

```
nixpkgs / nix-darwin 24.11            ← the one real pin (root cause)
├─ Ruby ceiling 3.4.x (nixpkgs 24.11 has no ruby_4_0)
│   └─ brew capped at 5.0.16          (5.1.0+ needs Ruby 4.0)   → brew-src pin
│       └─ depends_on bug in 5.0.x                              → loader patch
└─ nix-darwin 24.11
    └─ nix-homebrew stuck on old rev  (newer rev asserts        → nix-homebrew
       "system-wide activation", needs nix-darwin > 24.11)        rev pin
```

`5.0.16` is the **newest brew still on portable Ruby 3.4** (5.0.5→3.4.7,
5.0.16→3.4.8). `5.1.0` is the first to require Ruby `4.0.x`, which nixpkgs 24.11
does not provide — that's the hard ceiling.

**The bug the patch fixes:** a cask with a bare `depends_on :macos` serializes in
the Homebrew JSON API as `{"macos": {}}`. The loader does `value.keys.first`
(→ `nil` for the empty hash) then `value[nil].first`, raising
`undefined method 'first' for nil`. This crashes **install and cleanup** for any
such cask — **29 of our casks** (miniconda, xquartz, firefox, steam, vscode,
discord, …). In 5.0.x this parsing lives in `Library/Homebrew/api/cask.rb`
(`#depends_on_args`); earlier (4.5.2) it was in `cask/cask_loader.rb`. Fixed
upstream only in the Ruby-4.0 line. The patch adds one guard line:

```ruby
next [key, nil] if dep_type.nil?   # bare `depends_on :macos` → no constraint
version_symbol = value[dep_type].first
```

## What is temporary (all in `flake.nix`)

| Piece | Status | Remove when… |
| --- | --- | --- |
| top-level `brew-src` input pinned to `5.0.16` | **Temporary** | base → nixpkgs with `ruby_4_0` |
| `nix-homebrew.inputs.brew-src.follows = "brew-src"` | **Temporary** | same |
| `brew-src` in the `outputs` argument set | **Temporary** | same |
| `nix-homebrew` rev pin (`4945f47…`) | **Temporary** | base → nix-darwin > 24.11 |
| `nix-homebrew.package` loader-patch module | **Temporary** | brew → version with the upstream fix |

> [!NOTE]
> Two earlier stopgaps were already reverted and are **not** in the tree:
> `environment.variables.HOMEBREW_NO_INSTALL_CLEANUP` (was in `apps/brew.nix`)
> and a commented-out `brew cleanup -s` (in `shell/.functions`). Both work
> normally again on brew 5.0.16.

## What a macOS update does

| Update macOS to… | brew 5.0.16 + patch | base 24.11 | Action |
| --- | --- | --- | --- |
| later Sequoia (15.x) | ✅ works | ✅ same Darwin major | nothing |
| **26 (Tahoe)** | ✅ supported (≤ 26) | ⚠️ predates Tahoe — must verify | bump the base (see below) |
| 27 (future) | ❌ unsupported by 5.0.16 | ❌ | forces brew + base bump |

Verified from the built brew: `HOMEBREW_MACOS_NEWEST_SUPPORTED="26"`,
`HOMEBREW_MACOS_NEWEST_UNSUPPORTED="27"`, `HOMEBREW_MACOS_OLDEST_SUPPORTED="14"`.

## Known residual limitation: the source-DSL treadmill (expected until Tahoe)

The loader patch fixes **loading/metadata** (so `brew info`/already-installed
casks work). But pinned brew **5.0.16** (the newest on Ruby 3.4, ~Nov 2025) is
months behind the cask **source DSL**, which keeps moving. So actually
*installing/upgrading/adopting* a cask that brew has to evaluate from its Ruby
source (`API Source <cask>.rb` — used for casks with arch-conditional URLs,
`livecheck`, install/uninstall scripts, etc.) can fail in several ways. **This is
expected** on the 24.11 stack and is fully resolved only by the base bump.

Observed failure modes (`nix-update` run, 2026-05):

| Casks | Error | Cause |
| --- | --- | --- |
| virtualbox, librewolf | `wrong number of arguments (given 1, expected 0)` | source uses bare **`depends_on :macos`** (positional); 5.0.16's DSL wants keyword args — newer syntax |
| libreoffice, inkscape | `does not run on macOS versions other than Big Sur` | source uses **`depends_on macos: :big_sur`** (bare symbol); current brew reads it as **`>=`**, 5.0.16 reads it as **exact** |
| balenaetcher, knockknock, lulu | `existing App is different … --adopt` | the app in `/Applications` isn't brew-managed and is **older** than the cask (pre-existing, brew-version-independent) |
| mas → Parcel | `mas installation failed` | Mac App Store hiccup (unrelated to brew/nix) |

> [!NOTE]
> The first two rows are pure version skew and will keep producing **new**
> incompatibilities each time upstream cask data advances — patching brew's DSL
> per-error is a losing game, so we don't. The bottom two are independent of the
> brew pin.

**Interim handling (chosen):**

- Everything **already installed keeps working** — these failures only block
  *upgrades/adopts*, leaving the installed version in place.
- Upgrade affected apps manually if/when needed (download from vendor, or
  `brew reinstall --cask <name>` once the app/cask versions line up).
- For the `--adopt` mismatches, either update the app to the cask's version first,
  or remove the stale `/Applications/<App>` and let brew install fresh. Do **not**
  just delete the cask from `brew.nix` — `onActivation.cleanup = "zap"` would then
  uninstall it.
- `librewolf` is upstream-deprecated (Gatekeeper) and slated for disable
  2026-09-01 regardless.
- `nix-update` ends in `[SUCCESS]` even when these casks fail: the system config
  **does** activate; brew bundle just reports the cask errors. The function's
  rebuild step is intentionally a `warning` (not a hard error) for this reason —
  but always skim the output for a *real* nix build error above it.

The base bump (current brew on Ruby 4.0) resolves **all** of the version-skew rows.

## The Tahoe upgrade playbook (coupled full bump)

The newer `nix-homebrew` (2026-05) injects **nixpkgs's** Ruby into brew and now
uses **`pkgs.ruby_4_0`** (the old rev used `ruby_3_4`); its default `brew-src` is
already a current brew (5.1.x). So a clean bump removes all the scaffolding —
**provided the target nixpkgs ships `ruby_4_0`**.

### 0. Pre-flight (verify, don't assume)

- [ ] Target **nixpkgs has `pkgs.ruby_4_0`** — 24.11 does not. Check the
      candidate release/channel before committing.
      `nix eval <channel>#ruby_4_0.version`
- [ ] Target **nix-darwin supports macOS 26 (Tahoe)** and has **system-wide
      activation** (required by latest nix-homebrew).
- [ ] Note the **`stateVersion`** / breaking-change migration for nix-darwin and
      home-manager across `24.11 → <target>`.

### 1. Bump the inputs in `flake.nix`

- `nixpkgs` → a `*-darwin` release that has `ruby_4_0` **and** Tahoe support.
- `nix-darwin` → matching release.
- `home-manager` → matching release.
- `nix-homebrew` → drop the rev pin: `url = "github:zhaofengli/nix-homebrew";`

### 2. Delete the scaffolding in `flake.nix`

- Remove the top-level `brew-src` input.
- Remove `inputs.brew-src.follows = "brew-src"` from `nix-homebrew`.
- Remove `brew-src` from the `outputs = inputs@{ … }` argument set.
- Remove the entire `nix-homebrew.package` loader-patch module.

The `nix-homebrew` input then collapses back to just:

```nix
nix-homebrew.url = "github:zhaofengli/nix-homebrew";
```

### 3. Re-lock & dry-build (gates)

```bash
nix flake update --impure
darwin-rebuild build --flake .#concord --impure   # must succeed, no activation
```

A failure here catches: missing `ruby_4_0`, nix-darwin↔nix-homebrew mismatch,
or module breakage from the base bump.

### 4. Verify brew picked up the upstream fix (so the patch is truly unneeded)

```bash
./result/... brew --version          # expect Homebrew 5.1.x
brew info --cask miniconda           # must NOT crash — confirms loader fix
```

### 5. Activate

```bash
nix-update          # runs darwin-rebuild switch + brew bundle
```

### 6. Fix base-bump fallout (separate, broad)

The brew part is the easy part. Expect to chase `24.11 → <target>` breaking
changes across the home-manager / nix-darwin modules. Treat this as the bulk of
the work.

## Fallback: Tahoe-capable nixpkgs without `ruby_4_0`

Tahoe support (nix-darwin) and `ruby_4_0` (nixpkgs) may not land in the same
release. If you must move to Tahoe but the Tahoe-capable nixpkgs lacks
`ruby_4_0`, keep the **decoupled** state:

- Bump `nixpkgs` / `nix-darwin` / `home-manager` for Tahoe.
- **Keep** the brew 5.0.0 pin + loader patch, and **keep** `nix-homebrew` on the
  old rev (it doesn't require system-wide activation).
- Verify the old `nix-homebrew` rev still evaluates against the newer nix-darwin;
  if not, find the newest nix-homebrew rev that (a) works with your nix-darwin and
  (b) still uses `ruby_3_4`.

Drop the scaffolding later, once a nixpkgs with `ruby_4_0` + Tahoe is available.

## Rollback

- Config: `git restore flake.nix flake.lock` (or revert the commit).
- System: `darwin-rebuild --rollback`, or boot an earlier nix-darwin generation.
