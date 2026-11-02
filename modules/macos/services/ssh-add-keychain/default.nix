{ ... }:

{
  # Reloads the SSH keys from the Apple keychain at every session login.
  # Why: the OpenSSH shipped by Nix (/run/current-system/sw/bin/ssh) is upstream and does not
  # understand `UseKeychain` (Apple-only lazy loading). So the SHARED agent (launchd's,
  # $SSH_AUTH_SOCK) is filled once per session with APPLE's binary (/usr/bin/ssh-add), the only
  # one able to read the passphrase from the keychain.
  # One-shot prerequisite per key (already done for ~/.ssh/private/infra, 2026-07-22):
  #   /usr/bin/ssh-add --apple-use-keychain <path-to-key>
  # Security: the passphrase is encrypted in the login keychain (FileVault at rest), the same
  # threat model as a manual ssh-add, without retyping it at every boot.
  launchd.user.agents.ssh-add-keychain = {
    serviceConfig = {
      ProgramArguments = [
        "/usr/bin/ssh-add"
        "--apple-load-keychain"
      ];
      RunAtLoad = true;
    };
  };
}
