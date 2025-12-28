# Load user configs

{ config, pkgs, ... }:

{
  imports = [
    ./users.nix
  ];
}
