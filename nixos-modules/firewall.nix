{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.enableStrongSwan = true;

  networking.extraHosts = ''
    10.10.2.4 myevtfbedev.blob.core.windows.net
    10.0.5.10 myevtfbe.blob.core.windows.net
  '';

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    53
    80
    137
    443
    1935
    1433
    2379
    2380
    3000
    4240
    4244
    4245
    4250
    4251
    500
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
  networking.firewall.allowedUDPPorts = [
    53
    80
    137
    443
    1935
    500
    3000
    4500
    4789
    1433
    6081
    6443
    8132
    8181
    8472
    51871
  ];

}
