# NixOS configuration

{ config, pkgs, ... }:

{
  # Allow the nixos group to edit anything in /etc/nixos folder
  systemd.tmpfiles.settings = {
    "set-nixos-group" = {
      "/etc/nixos" = {
        Z = {
          group = "nixos";
          mode = "~0775";
          user = "root";
        };
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the Flakes feature and new nix-command tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Nix GC: deletes old profile backups and unused packages
  nix.gc = {
    automatic = true;
    dates = "weekly";
    persistent = true;
    options = "--delete-older-than 30d"; #nix-collect-garbage -d can be run to collect garbage immediately
    
  };

  # Nix storage optimisation
  nix.optimise.automatic = true;
}
