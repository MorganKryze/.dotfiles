{ ... }:

{
  # Recreates /var/run/docker.sock at boot so Docker Desktop stops asking for the
  # admin password on every start.
  # Why: with "Allow the default Docker socket to be used" (EnableDefaultDockerSocket)
  # Docker Desktop symlinks /var/run/docker.sock to its per-user socket. macOS wipes
  # /var/run on every boot, so Docker needs root to recreate the link each time and
  # prompts for it. This daemon runs as root at boot, before login, and creates the
  # link first; Docker then finds it in place. The link dangles until Docker starts,
  # which is harmless.
  launchd.daemons.docker-socket = {
    serviceConfig = {
      ProgramArguments = [
        "/bin/ln"
        "-sfh"
        "/Users/morgan/.docker/run/docker.sock"
        "/var/run/docker.sock"
      ];
      RunAtLoad = true;
    };
  };
}
