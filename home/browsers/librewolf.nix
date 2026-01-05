# Librewolf config

{ osConfig, config, pkgs, ... }:

{
  programs.librewolf = {
    enable = true;

    profiles = {
      pomal = {
        name = "Pope Malcom";
        search.force = true; # Replace config with one defined here
        search.engines = {
          nix-packages = {
            name = "Nix Packages";
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
        };
      };
    };
  };

  stylix.targets.librewolf.profileNames = [ "pomal" ];
}
