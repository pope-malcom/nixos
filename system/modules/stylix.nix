# System level stylix config
{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    
    image = ../../wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/penumbra-dark-contrast-plus-plus.yaml";

    # https://github.com/simtrami/posy-improved-cursor-linux
    cursor = {
      name = "Posy_Cursor_Mono_Black";
      package = pkgs.posy-cursors;
      size = 22;
    };
  };
}
