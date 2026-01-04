# Load console configs

{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./aliases.nix
    ./starship.nix
    ./zsh.nix 
  ];
}
