# Load system level programs

{ config, pkgs, ... }:

{
  imports = [
    ./stylix.nix
    ./utils.nix
  ];
}
