# Load user desktop configs
{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  custom = {
    hyprlandConfig.enable = config.programs.hyprland.enable;
  };
}
