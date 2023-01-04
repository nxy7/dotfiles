{ pkgs, ... }: {
  services.udev.extraRules = ''
    # Picoprobe
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0xcafe", MODE="0666", GROUP="embeddev", SYMLINK+="picoprobe"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0x303a", MODE="0666", GROUP="embeddev"
    KERNEL=="ttyACM0", MODE="0666", GROUP="embeddev"
    KERNEL=="hidraw7", MODE="0666", GROUP="embeddev"
    KERNEL=="hidraw4", MODE="0666", GROUP="embeddev"

    # GoXLR
    SUBSYSTEM=="usb", ATTR{idVendor}=="1220", ATTR{idProduct}=="8fe4", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="1220", ATTR{idProduct}=="8fe0", MODE="0666"

    SUBSYSTEM=="usb", ATTR{idVendor}=="8fe0", ATTR{idProduct}=="0301", MODE="0666"

    ${builtins.readFile ./69-probe-rs.rules}
  '';

}
