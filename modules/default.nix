# Load module configs

{ config, pkgs, ... }:

{
  imports = [
    ./nix-flatpak.nix
  ];
}
