# Load user specific configs

{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./nix-flatpak.nix
  ];
}
