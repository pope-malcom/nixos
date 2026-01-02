# Load user desktop configs
{ osConfig, config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  custom = {
    hyprlandConfig.enable = osConfig.programs.hyprland.enable;
  };
}
