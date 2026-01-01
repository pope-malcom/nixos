# Load program configs

{ config, pkgs, ... }:

{
  imports = [
    ./editors.nix
    ./utils.nix
  ];
}
