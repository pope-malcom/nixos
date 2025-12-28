# Global host settings

{ config, pkgs, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;


  # Set time zone automatically
  services.automatic-timezoned.enable = true;


  # Enable firmware updates
  services.fwupd.enable = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}
