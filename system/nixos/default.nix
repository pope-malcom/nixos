# Load NixOS configs

{ config, pkgs, ... }:

{
  imports = [
    ./locale.nix
    ./nixos.nix
    ./secrets.nix
    ./stateVersion.nix
  ];
}
