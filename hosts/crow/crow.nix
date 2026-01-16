# Defines specific configurations for crow

{ config, pkgs, inputs, ... }:

{
  imports = [ 
    # NixOS hardware options for Framework 13 AMD AI 300 series
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series 
  ];

  # Hostname
  networking.hostName = "crow";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    
      # Hide OS choice. Pressing any key should make it reappear
      timeout = 0;
    };

    # Plymouth: boot logo customisation
    plymouth.enable = true;

    # Silent boot
    consoleLogLevel = 3;
    initrd.verbose = false;
    initrd.systemd.enable = true;
    kernelParams = [
      "quiet"
      "splash"
      "intremap=on"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };
  
  # Minimal greetd setup. Automatically logs into hyprland as pomal
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/hyprland";
        user = "pomal";
      };
      default_session = initial_session;
    };
  };

  # Enable fingerprint scanner
  services.fprintd.enable = true;

  # Touchpad (likely already enabled in desktop manager)
  services.libinput.enable = true;

  # Keymap: configured through xserver and copied to console
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  console.useXkbConfig = true;

  # Disable sensors (maybe saving power)
  hardware.sensor.iio.enable = false;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;   
}
