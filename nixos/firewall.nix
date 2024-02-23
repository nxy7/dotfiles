{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.enableStrongSwan = true;

  networking.extraHosts = "";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    53
    80
    137
    443
    2379
    2380
    4240
    4244
    4245
    4250
    4251
    4500
    6060
    6061
    6062
    6081
    6443
    8132
    8132
    8133
    8181
    8472
    9443
    9878
    9879
    9890
    9891
    9893
    9962
    9963
    9964
    10250
  ];
  networking.firewall.allowedUDPPorts =
    [ 53 80 137 443 4789 6081 6443 8132 8181 8472 51871 ];

}
