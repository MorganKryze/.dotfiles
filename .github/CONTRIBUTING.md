# Contributing

These are personal dotfiles, tuned for one machine. Issues and suggestions are welcome; pull requests may be declined
if they don't fit how I use the setup. Please follow the [Code of Conduct](CODE_OF_CONDUCT.md).

## Before opening a pull request

1. Check where the change belongs in the [packaging policy](../docs/packaging.md).
2. Make sure the configuration still builds, without activating it:

   ```bash
   nix build .#darwinConfigurations.concord.system
   ```

3. Format with `nix fmt -- $(git ls-files '*.nix')`, and run `shellcheck` on the shell scripts you touched.

## Commit messages

[Conventional Commits](https://www.conventionalcommits.org/), with the area as scope:

```
feat(homebrew): add opencode to the brews
fix(zsh): drop the stale Vagrant completion path
docs(readme): document the daily commands
```

Types used: `feat`, `fix`, `refactor`, `docs`, `chore`, `style`, `perf`. Use the imperative mood, keep the subject
short.

## Contact

<morgan@kodelab.fr>
