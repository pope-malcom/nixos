# NixOS configuration

{ config, pkgs, inputs, ... }:

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

  # Enable automatic updates (respective of flake)
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos/"; # User version updated by nixos-flake-update
    flags = [
      "--print-build-logs"
    ];
    dates = "daily";
    randomizedDelaySec = "45min";
    upgrade = false;
    persistent = true;
  };

  # nix flake update service
  # Runs before auto upgrade service, updates flake.lock
  systemd.services."nixos-flake-update" = {
    description = "flake.lock update";
    documentation = [ "man:nix3-flake-lock" ];
    script = ''
      set -eu
      ${pkgs.nix}/bin/nix flake update --flake /etc/nixos/ --commit-lock-file
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    wantedBy = [ "nixos-upgrade.service" ];
    before = [ "nixos-upgrade.service" ];
  };

  # Enable firmware update commands
  services.fwupd.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set time zone automatically
  services.automatic-timezoned.enable = true;

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
