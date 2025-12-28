# Configure system utility programs

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    nano
    vim
    wget
  ];
}
