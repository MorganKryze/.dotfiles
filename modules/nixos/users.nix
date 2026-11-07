{ pkgs, ... }:
let
  # The Mac's key, also published at github.com/MorganKryze.keys
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID6oaW22Ig9UPt49/c5C/wB3ckDTf/vWOG3boptRs2eF"
  ];
in
{
  programs.zsh.enable = true;

  users.users.morgan = {
    isNormalUser = true;
    description = "Morgan";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = sshKeys;
  };

  # Root has no password: only the Mac's key, for `nixos-rebuild --target-host`.
  users.users.root.openssh.authorizedKeys.keys = sshKeys;
}
