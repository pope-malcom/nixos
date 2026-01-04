# Load user desktop configs
{ osConfig, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  home.desktop = {
    hyprland.enable = osConfig.programs.hyprland.enable;
    waybar.enable = osConfig.programs.hyprland.enable;
  };
}
