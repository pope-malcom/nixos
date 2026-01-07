# Config for Hyprland

{ config, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # TODO Move this somewhere sensible
  services.blueman.enable = true;
}
