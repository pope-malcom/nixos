# Setup custom udev rules, for device permissions

{ ... }:

{
  services.udev.extraRules = ''
    # Siglent 1204X-E oscilloscope
    SUBSYSTEM=="usb", ATTR{idVendor}=="f4ec", ATTR{idProduct}=="ee38", MODE="0666"

    # Exibel USB Ethernet adapter
    SUBSYSTEM=="usb", ATTR{idVendor}="0b95", ATTR{idProduct}=="1790", MODE="0666"
  '';

}
