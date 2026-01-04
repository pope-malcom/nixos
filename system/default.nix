# Load system level configs

{ config, pkgs, ... }:

{
  imports = [
    ./desktop
    ./hardware
    ./kernel
    ./modules
    ./nixos
    ./shell
  ];
}
