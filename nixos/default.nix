{
  imports = [
    ./kernel.nix
    ./antivirus.nix
    ./firewall.nix
    ./samba.nix
    ./vpn.nix

    ./packages.nix
    ./services.nix
    ./users.nix
    ./programs.nix
    ./udev.nix
  ];
}
