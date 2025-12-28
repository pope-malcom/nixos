# Load kernel configs

{ config, pkgs, ... }:

{
  imports = [
    ./kernel.nix
  ];
}
