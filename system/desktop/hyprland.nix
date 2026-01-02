# Config for Hyprland

{ config, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
