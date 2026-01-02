# User hyprland configuration
{ osConfig, config, lib, ... }:

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
        xwayland.force_zero_scaling = true;

        bind = [
          "SUPER, T, exec, ${config.programs.alacritty.package}/bin/alacritty"
          "SUPER, N, exec, ${config.programs.firefox.package}/bin/firefox"
          "SUPER, Q, killactive"
        ];
      };
    };
  };
}
