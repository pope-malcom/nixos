# Load locale configs

{ config, pkgs, ... }:

{
  imports = [
    ./locale.nix
  ];
}
