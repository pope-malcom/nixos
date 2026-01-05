# System level stylix config
{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    
    image = ../../wallpaper.jpg;
    #polarity = "dark";

    #base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-savanna.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/penumbra-dark-contrast-plus-plus.yaml";
    #fonts = {
    #  serif = config.stylix.fonts.monospace;
    #  sansSerif = config.stylix.fonts.monospace;
    #  emoji = config.stylix.fonts.monospace;
    #};
  };
}
