{
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # SSH agent for the user's keys (GitHub, servers): one passphrase per session
  programs.ssh.startAgent = true;

  # Key-only SSH, so the Mac can administer and deploy (authorized keys are in
  # users.nix). openssh opens port 22 in the firewall.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
