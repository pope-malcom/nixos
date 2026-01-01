# Load program configs

{ config, pkgs, ... }:

{
  imports = [
    ./nixvim.nix
    ./utils.nix
  ];
}
