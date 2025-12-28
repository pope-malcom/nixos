# Configure user utilities

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    
    # Archives
    zip
    unzip

    # Networking
    socat # Modern replacement of netcat
    nmap

    # System monitoring
    btop
  ];
}
