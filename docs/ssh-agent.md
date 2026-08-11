# SSH agent, keychain and the stale-socket trap

> Why `ssh-add -l` can say **"Error connecting to agent: No such file or directory"** while your
> keys are perfectly loaded — and how to check what actually survives a reboot.
> Written after chasing this across WezTerm and the VS Code terminal on 2026-08-11.

## How keys get loaded on this machine

Two pieces, and they are easy to confuse.

**The passphrase lives in the login keychain.** Registering a key is a one-shot, per key:

```sh
/usr/bin/ssh-add --apple-use-keychain ~/.ssh/private/<key>
```

⚠️ Use **Apple's** binary, not the Nix one. `/run/current-system/sw/bin/ssh-add` is upstream OpenSSH
and knows nothing about the macOS keychain.

**A launchd agent replays them at every login.** `modules/macos/services/ssh-add-keychain` runs
`/usr/bin/ssh-add --apple-load-keychain` with `RunAtLoad`, filling the **shared** agent — the one
macOS advertises through `SSH_AUTH_SOCK`.

So: the keychain is the durable store, the agent is the volatile one. `ssh-add -l` only ever tells
you about the agent it can currently reach — which is the whole problem below.

## The trap: a dead socket you inherit

Some terminals start **their own** SSH agent and override `SSH_AUTH_SOCK`. WezTerm does it by
default, pointing at `~/.local/share/wezterm/agent.<pid>`.

Everything launched from that terminal inherits the variable — VS Code, and therefore its integrated
terminal, and therefore anything you run from it. When the owning WezTerm process dies, **the socket
file disappears but the variable survives** in every descendant. You then get:

```
Error connecting to agent: No such file or directory
```

…while the keys sit loaded in the launchd agent, untouched. The message points at the agent, the
fault is in the environment.

Two fixes, and both are wanted — the first prevents it, the second repairs what already inherited it:

| where | what |
| --- | --- |
| `apps/wezterm/.wezterm.lua` | `config.mux_enable_ssh_agent = false` — stop overriding the variable |
| `shell/.exports` | rewrite `SSH_AUTH_SOCK` **only if** it is not a live socket, falling back to `launchctl getenv SSH_AUTH_SOCK` |

The shell guard is deliberately conservative: it never touches a variable that points at a working
agent, so a legitimate forwarded agent (`ssh -A`) is left alone. It lives in `.exports`, sourced from
`.zshenv`, so it applies to **every** zsh — interactive or not.

## Checking what the keychain will restore

`ssh-add -l` answers "what is loaded right now". The useful question is **"what comes back after a
reboot"**, and only the keychain answers that. Test it in a throwaway agent, so the real one is never
disturbed:

```sh
SOCK=/tmp/agent-test.$$
eval "$(ssh-agent -a "$SOCK" -s)" >/dev/null
SSH_AUTH_SOCK=$SOCK /usr/bin/ssh-add --apple-load-keychain   # what the keychain restores
SSH_AUTH_SOCK=$SOCK ssh-add -l
ssh-agent -k >/dev/null; rm -f "$SOCK"
```

State on 2026-08-11 — **2 keys registered**: `private/infra` (the fleet) and `private/git`. The seven
others (`backup`, `default`, `dvfl`, `fleet`, `frigate`, `git-sk`, `homelab`) are **not** in the
keychain and will not come back on their own.

⚠️ **Do not try to answer this with `security find-generic-password`.** Five plausible attribute
forms (`-s "SSH: <path>"`, `-a <path>`, `-l <path>`, service `OpenSSH`, `-D "application password"`)
all returned *not found* for keys that are demonstrably in the keychain. Whatever schema Apple's
`ssh-add` uses, guessing it produces a **false negative** — and acting on it means re-registering keys
that were already there. The functional test above sidesteps the schema entirely by observing
behaviour.

## Registering another key

```sh
/usr/bin/ssh-add --apple-use-keychain ~/.ssh/private/<key>   # asks the passphrase once
```

Then re-run the throwaway-agent check above to confirm it shows up.

Keep the list tight. Every key in the agent is a key that any compromised process can use without
being asked for anything — the convenience is real, so is the blast radius.

## Quick triage

| symptom | look at |
| --- | --- |
| `Error connecting to agent` | `echo $SSH_AUTH_SOCK`, then `[ -S "$SSH_AUTH_SOCK" ]` — dead socket inherited? |
| agent reachable but empty | `launchctl print gui/$(id -u)/ssh-add-keychain` — did the service run? |
| a specific key missing | the throwaway-agent test — is it in the keychain at all? |
| permission denied on a host | `ssh-add -l` lists it, but is the **public** half in the host's `authorized_keys`? |
