# Load hardware configs

{ config, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./udev.nix
  ];
}
