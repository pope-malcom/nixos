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
    # TODO Find somewhere better for these
    services.mako.enable = true;
    programs.tofi = {
      enable = true;
      settings = {
        #background-color = "#000000";
        border-width = 0;
        #font = "monospace";
        height = "100%";
        num-results = 5;
        outline-width = 0;
        padding-left = "35%";
        padding-top = "35%";
        result-spacing = 25;
        width = "100%";
      };
    };

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
          "SUPER, L, exec, ${config.programs.tofi.package}/bin/tofi-drun | xargs hyprctl dispatch exec"
          "SUPER, Q, killactive"
        ]
        ++ (
          # Workspace movement
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "SUPER, code:1${toString i}, workspace, ${toString ws}"
              "SUPER + SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
        );
      };
    };
  };
}
