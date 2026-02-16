# Setup custom udev rules, for device permissions

{ ... }:

{
  services.udev.extraRules = ''
    # Siglent 1204X-E oscilloscope
    SUBSYSTEM=="usb", ATTR{idVendor}=="f4ec", ATTR{idProduct}=="ee38", MODE="0666"
  '';
}
