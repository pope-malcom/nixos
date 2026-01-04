# Load NixOS configs

{ config, pkgs, ... }:

{
  imports = [
    ./locale.nix
    ./nixos.nix
    ./stateVersion.nix
  ];
}
