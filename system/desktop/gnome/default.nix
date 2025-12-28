# Load GNOME configs

{ config, pkgs, ... }:

{
  imports = [
    ./gnome.nix
  ];
}
