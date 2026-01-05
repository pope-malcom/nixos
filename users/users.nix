# Set up each user

{ config, pkgs, inputs, ... }:

{
  # Custom groups
  users.groups = {
    nixos = {};
  };

  # TODO: Put this into a for <each user> loop
  imports = [
    # Load configuration file for each user
    ./pomal/user.nix

    # Add home-manager config per user
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs.flake-inputs = inputs;
      home-manager.backupFileExtension = "old";
      home-manager.users = {
        pomal = import ./pomal/home.nix;
      };
    }
  ];

  # Users not defined in NixOS configs are deleted
  # users.mutableUsers = false;
}
