{ pkgs, config, inputs, ... }: {
  environment.systemPackages = (with pkgs; [
    strongswan
    wireguard-tools
    openvpn
    nmap
    networkmanagerapplet
    networkmanager_strongswan
    networkmanager-vpnc
  ]);
}
