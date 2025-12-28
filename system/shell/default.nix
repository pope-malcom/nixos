# Load shell/terminal configs

{ config, pkgs, ... }:

{
  imports = [
    ./zsh.nix
  ];
}
    
