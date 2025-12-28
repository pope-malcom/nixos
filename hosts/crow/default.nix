# Simply load all nix configurations

{ config, pkgs, ... }:

{
  imports = [
    ./crow.nix
    ./hardware-configuration.nix
    ./power.nix
  ];
}
