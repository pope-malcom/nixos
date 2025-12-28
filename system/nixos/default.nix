# Load NixOS configs

{ config, pkgs, ... }:

{
  imports = [
    ./nixos.nix
    ./stateVersion.nix
  ];
}
