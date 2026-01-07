# waybar configuration
{ config, lib, ... }:

let
  inherit (lib)
    mkIf
    mkEnableOption
  ;
in
{
  options.home.desktop.waybar = {
    enable = mkEnableOption "Waybar";
  };

  config = mkIf config.home.desktop.waybar.enable {
    programs.waybar.enable = true;

    # TODO Find a better place for these
    services.blueman-applet.enable = true;
  };
}
