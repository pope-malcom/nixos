# Load system level configs

{ config, pkgs, ... }:

{
  imports = [
    ./desktop
    ./hardware
    ./kernel
    ./locale
    ./nixos
    ./programs
    ./shell
  ];
}
