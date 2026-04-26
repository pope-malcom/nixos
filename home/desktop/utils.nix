# Utils for desktop
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
  ];
}
