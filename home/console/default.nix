# Load console configs

{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./starship.nix
  ];
}
