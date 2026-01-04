# Configs for zsh

{ config, pkgs, ... }:

{
  programs.zsh.enable = true;    

  # Make default for all users
  users.defaultUserShell = pkgs.zsh;
}
