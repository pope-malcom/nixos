# Configure nix-flatpaks

{ config, pkgs, flake-inputs, ... }:

{
  # services.flatpak.enable = true must be set at the system level 

  imports = [
    flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  # Auto updates
  services.flatpak.update = {
    onActivation = true; # Update on nixos-rebuild
    auto.enable = true;
    auto.onCalendar = "weekly";
  };

  # Remove flatpaks not tracked by nix-flatpak
  services.flatpak.uninstallUnmanaged = true; 


  # Flatpaks to be installed
  services.flatpak.packages = [
    "com.discordapp.Discord"
    "com.valvesoftware.Steam"
  ];  
}
