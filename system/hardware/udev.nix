# Setup custom udev rules, for device permissions

{ ... }:

{
  services.udev.extraRules = ''
    # Enable R/W on all USB devices 
    SUBSYSTEM=="usb", DRIVER=="usb", MODE="0666"
  '';

}
