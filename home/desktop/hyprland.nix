# User hyprland configuration
{ config, lib, osConfig, ... }:

let
  inherit (lib)
    mkIf
    mkEnableOption
  ;
in
{
  options.home.desktop.hyprland = {
    enable = mkEnableOption "hyprland"; 
  };
  
  config = mkIf config.home.desktop.hyprland.enable {
    services.mako.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = true;
      settings = {
        input = {
          kb_layout = osConfig.services.xserver.xkb.layout;
          follow_mouse = 1;
          touchpad.natural_scroll = "yes";
        };

        exec-once = "waybar";

        xwayland.force_zero_scaling = true;
        monitor = [
          "eDP-1, 2880x1920@120, 0x0, 2"
          ", preferred, auto, 1"
        ];

        bind = [
          "SUPER, T, exec, ${config.programs.alacritty.package}/bin/alacritty"
          "SUPER, N, exec, ${config.programs.librewolf.package}/bin/librewolf"
          "SUPER, Q, killactive"
        ];
      };
    };
  };
}
