# Load console configs

{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./aliases.nix
    ./direnv.nix
    ./starship.nix
    ./zsh.nix 
  ];
}
