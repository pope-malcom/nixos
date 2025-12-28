# Linux kernel configuration

{ config, pkgs, ... }:

{
  # Set kernel to latest
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
