# Config nix-flatpak

{ config, pkgs, ... }:

{
  services.flatpak.enable = true;

  # Stop users from manually installing flatpaks!
  # TODO: Make this prettier!
  environment.shellAliases = {
    flatpak = "echo Do not use flatpak directly! Add content to /etc/nixos/users/$USER/programs/nix-flatpak.nix";
  };
}
