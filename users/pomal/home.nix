# home-manager config for Pope Malcom

{ config, pkgs, flake-inputs, ... }:

{
  imports = [
    # Default home programs
    ../../home

    # Programs unique to this user
    ./programs
  ];
  
  home.username = "pomal";
  home.homeDirectory = "/home/pomal";

  # State version: this doesn't need to be updated
  home.stateVersion = "25.11";  
}
