# NixOS configuration

{ config, pkgs, lib, inputs, ... }:

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

  # Check if the network is connected
  systemd.services."NetworkManager-check-connection" = {
    description = "NetworkManager connection check";
    path = [ pkgs.networkmanager ];
    script = ''
      nm-online --timeout=30 -q 
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    requiredBy = [ "network-connected.target" ];
    before = [ "network-connected.target" ];
  };

  systemd.targets."network-connected" = {
    description = "Network connection established";
  };

  # Enable automatic updates (respective of flake)
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos/"; # Use the version updated by nixos-flake-update
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
    documentation = [ "man:nix3-flake-update" ];
    path = [ pkgs.nix pkgs.git pkgs.iputils pkgs.util-linux];
    script = ''
      set -eu
      # Update flake
      cd /etc/nixos
      old_uname=$(git config user.name)
      git config user.name "nixos-flake-update service"
      nix flake update --commit-lock-file
      git config user.name $old_uname

      echo "Commited flake.lock to git"

      exit 0
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      
      # Make the service auto restart, 
      Restart = "on-failure";
      RestartSec = "10s";
      RestartSteps = "5";
      RestartMaxDelaySec = "1h";
    };

    unitConfig = {
      # Only restart 5 times
      StartLimitBurst = "5";
      StartLimitIntervalSec = "infinity";
    };

    # Targets copied from nixos-upgrade.service
    requiredBy = [ "nixos-upgrade.service" ];
    before = [ "nixos-upgrade.service" ];
    requires = [ "network-connected.target" ];
    after = [ "network-connected.target" ];
  };

  # Install nerdfont symbols
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
  ];

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
    options = "--delete-older-than 14d"; #nix-collect-garbage -d can be run to collect garbage immediately
    
  };

  # Nix storage optimisation
  nix.optimise.automatic = true;
}
