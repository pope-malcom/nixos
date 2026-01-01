# User hyprland configuration
{ config, lib, ... }:

let
  inherit (lib)
    mkIf
    mkEnableOption
  ;
in
{
  options.custom.hyprlandConfig = {
    enable = mkEnableOption "hyprland Config"; 
  };
  
  config = mkIf config.custom.hyprlandConfig.enable {
    wayland.windowManager.hyprland.systemd.enable = false;
  };
}
