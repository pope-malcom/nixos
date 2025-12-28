# Configurations for Pope Malcom

{ config, pkgs, inputs, ... }:

{
  users.users.pomal = {
    isNormalUser = true;
    home = "/home/pomal";
    description = "Pope Malcom";
    extraGroups = [ "wheel" "networkmanager" "nixos"];
    shell = pkgs.zsh;
  };
}

