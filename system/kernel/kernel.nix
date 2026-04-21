# Linux kernel configuration

{ config, pkgs, ... }:

{
  # Set kernel to latest
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set to default value, latest had stability issues
  boot.kernelPackages = pkgs.linuxPackages;
}
