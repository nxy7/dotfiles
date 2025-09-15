{ pkgs, ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.plugins = with pkgs; [ networkmanager-strongswan ];

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
