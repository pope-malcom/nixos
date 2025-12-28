# Host settings
# 
# Manages host selection and imports global host settings

{ config, pkgs, ... }:

{
  # TODO: implement host selection
  imports = [
    ./crow
    ./global.nix
  ];
}
