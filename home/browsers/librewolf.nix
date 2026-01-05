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
            name = "NixOS Packages";
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

          nix-options = {
            name = "NixOS Options";
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{ 
              template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; 
            }];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [ "@nw" ];
          };
        };
      };
    };
  };

  stylix.targets.librewolf.profileNames = [ "pomal" ];
}
