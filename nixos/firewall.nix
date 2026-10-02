{ pkgs, ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # VPN plugins only register with NetworkManager through this list, not
    # environment.systemPackages. libreswan replaces the removed vpnc plugin
    # (Cisco-style IPsec).
    networkmanager.plugins = with pkgs; [
      networkmanager-strongswan
      networkmanager-libreswan
    ];

    extraHosts = ''
      10.10.2.4 myevtfbedev.blob.core.windows.net
      10.0.5.10 myevtfbe.blob.core.windows.net
    '';

    firewall.enable = true;
    firewall.allowedTCPPorts = [
      80
      443
      3000
      4000
      4100
      4002
      4007
      7000
    ];
  };
}
