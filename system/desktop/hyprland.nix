# Config for Hyprland

{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # TODO Move this somewhere sensible
  services.blueman.enable = true;
}
