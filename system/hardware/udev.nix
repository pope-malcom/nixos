# Setup custom udev rules, for device permissions

{ ... }:

{
  services.udev.extraRules = ''
    # Exibel USB Ethernet adapter
    SUBSYSTEM=="usb", ATTR{idVendor}="0b95", ATTR{idProduct}=="1790", MODE="0666"
  '';

}
