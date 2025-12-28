# Load hardware configs

{ config, pkgs, ... }:

{
  imports = [
    ./audio.nix
  ];
}
