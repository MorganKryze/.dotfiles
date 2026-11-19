{ pkgs, ... }:

let
  # Local HTTPS for Komodo, reached through tunny's SSH tunnel (localhost:9120).
  # Why: Komodo declares KOMODO_HOST = https://komodo.libresoftware.cloud and sets its session
  # cookie `Secure`. Over plain http://localhost (tunny), Safari drops that cookie, so TOTP
  # enrollment and the TOTP login fail ("TOTP enrollment has not been initiated for this session").
  # Caddy serves the exact name in HTTPS and relays to the tunnel. See the infra repo,
  # docs/kb/komodo-exploitation.md, "TOTP sur admin".
  # Prerequisites (one-shot, outside Nix): `127.0.0.1 komodo.libresoftware.cloud` in /etc/hosts,
  # and Caddy's local root CA trusted in the System keychain (Zen/Firefox: imported in the browser).
  # High ports: macOS refuses an unprivileged bind of 80/443 on 127.0.0.1, and listening on every
  # interface would expose Komodo to the LAN. A passkey would need the bare name (pf 443 -> 9443).
  caddyfile = pkgs.writeText "Caddyfile-komodo" ''
    {
    	admin off
    	local_certs
    	skip_install_trust
    	http_port 9080
    	https_port 9443
    }

    komodo.libresoftware.cloud:9443 {
    	bind 127.0.0.1
    	tls internal
    	reverse_proxy 127.0.0.1:9120
    }
  '';
in
{
  environment.systemPackages = [ pkgs.caddy ];

  launchd.user.agents.caddy-komodo = {
    serviceConfig = {
      ProgramArguments = [
        "${pkgs.caddy}/bin/caddy"
        "run"
        "--config"
        "${caddyfile}"
        "--adapter"
        "caddyfile"
      ];
      # Same HOME as an interactive run: Caddy keeps its local CA (already trusted) in
      # ~/Library/Application Support/Caddy. A different HOME would mint a new, untrusted CA.
      EnvironmentVariables.HOME = "/Users/morgan";
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/Users/morgan/Library/Logs/caddy-komodo.log";
      StandardErrorPath = "/Users/morgan/Library/Logs/caddy-komodo.log";
    };
  };
}
