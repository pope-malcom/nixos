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
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };
  
  # Automatic login with LUKS password
  services.displayManager.autoLogin.user = "pomal";

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

  # Should reduce screen flickering until a proper patch is deployed
  #boot.kernelParams = ["amdgpu.sg_display=0"];

  # Disable sensors (maybe saving power)
  hardware.sensor.iio.enable = false;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;   
}
