{
  imports = [
    ../nixos-modules/kernel.nix
    ../nixos-modules/antivirus.nix
    ../nixos-modules/firewall.nix
    ../nixos-modules/samba.nix
    ../nixos-modules/vpn.nix

    ../nixos-modules/packages.nix
    ../nixos-modules/services.nix
    ../nixos-modules/users.nix
    ../nixos-modules/programs.nix
    ../nixos-modules/udev.nix
  ];
}
