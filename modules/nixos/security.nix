{ pkgs, ... }:
{
  # Firewall (networking.nix) and key-only SSH (networking.nix) are the baseline.

  # On-demand checks, no resident daemon:
  # - lynis: system hardening audit, `sudo lynis audit system`
  # - ClamAV: `clamscan -r <dir>` on downloads, mostly useful for files heading
  #   to Windows. Only the signature updater runs (freshclam, daily); clamd would
  #   keep ~1 GB of signatures in RAM for little gain on a Linux desktop.
  environment.systemPackages = with pkgs; [
    lynis
    clamav
  ];
  services.clamav.updater.enable = true;
}
