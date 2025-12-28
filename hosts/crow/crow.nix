# Defines specific configurations for crow

{ config, pkgs, inputs, ... }:

{
  imports = [ 
    # NixOS hardware options for Framework 13 AMD AI 300 series
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series 
  ];

  # Hostname
  networking.hostName = "crow";

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Plymouth: boot logo customisation
  boot.plymouth.enable = true;

  # Touchpad (likely already enabled in desktop manager)
  services.libinput.enable = true;

  # Keymap: configured through xserver and copied to console
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  console.useXkbConfig = true;

  # Should reduce screen flickering until a proper patch is deployed
  boot.kernelParams = ["amdgpu.sg_display=0"];

  # Disable sensors (maybe saving power)
  hardware.sensor.iio.enable = false;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;   

}
