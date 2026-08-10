{ ... }:

{
  # Recharge les clés SSH depuis le trousseau Apple à chaque login de session.
  # Pourquoi : l'OpenSSH fourni par Nix (/run/current-system/sw/bin/ssh) est l'upstream — il ne
  # comprend pas `UseKeychain` (chargement paresseux propre à Apple). On peuple donc l'agent
  # PARTAGÉ (celui de launchd, $SSH_AUTH_SOCK) une fois par session, avec le binaire d'APPLE
  # (/usr/bin/ssh-add) — le seul qui sache lire la passphrase dans le trousseau.
  # Prérequis one-shot par clé (déjà fait pour ~/.ssh/private/infra, 2026-07-22) :
  #   /usr/bin/ssh-add --apple-use-keychain <chemin-de-la-clé>
  # Sécurité : passphrase chiffrée dans le trousseau login (FileVault au repos) — même modèle de
  # menace qu'un ssh-add manuel, sans la friction du re-typage à chaque boot.
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
