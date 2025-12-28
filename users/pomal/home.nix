# home-manager config for Pope Malcom

{ config, pkgs, flake-inputs, ... }:

{
  imports = [
    ../../home/browsers/firefox.nix
    ../../home/programs
    ../../home/console

     # programs unique to this user
    ./programs
  ];
  
  home.username = "pomal";
  home.homeDirectory = "/home/pomal";

  # State version: this doesn't need to be updated
  home.stateVersion = "25.11";  
}
