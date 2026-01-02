# Load desktop environment

{ config, pkgs, ... }:

{
  imports = [
    #./gnome.nix
    ./hyprland.nix
  ];
}
