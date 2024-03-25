{ pkgs, config, ... }: {
  environment.systemPackages = (with pkgs; [
    strongswan
    nmap
    networkmanagerapplet
    networkmanager_strongswan
    networkmanager-vpnc
  ]);
  services.openvpn.servers = { };

  services.strongswan = {
    enable = true;
    connections = {
      fsh = {
        keyexchange = "ikev2";
        type = "tunnel";
        leftfirewall = "yes";
        left = "%any";
        leftcert = "/home/nxyt/certs/client.crt";
        leftauth = "pubkey";
        leftid =
          "%dawidd"; # use the hostname of your machine with % character prepended. Example: %"client";
        right =
          "azuregateway-252a8e7a-35b7-4c65-a530-3cc6f2c11bee-d537aa23682e.vpn.azure.com";
        rightid =
          "%azuregateway-252a8e7a-35b7-4c65-a530-3cc6f2c11bee-d537aa23682e.vpn.azure.com";
        rightsubnet = "0.0.0.0/0";
        leftsourceip = "%config";
        auto = "start";
        esp = "aes256gcm16";
      };
    };
    secrets = [
      "/home/nxyt/certs/strongswan.secrets"
      "/home/nxyt/certs/client.key"
      "/home/nxyt/certs/*"
      "/home/nxyt/certs/clientcert.pfx"
      "/home/nxyt/certs/VpnServerRoot.cer_0"
    ];
    ca = {
      digi = {
        auto = "add";
        cacert = "/home/nxyt/certs/DigiCertGlobalRootCA.crt.pem";
      };
      digisha = {
        auto = "add";
        cacert = "/home/nxyt/certs/DigiCertSHA2SecureServerCA-2.crt.pem";
      };
      self = {
        auto = "add";
        cacert = "/home/nxyt/certs/VpnServerRoot.cer_0";
      };
      self2 = {
        auto = "add";
        cacert = "/home/nxyt/certs/ca.crt";
      };
    };
    setup = { strictcrlpolicy = "no"; };

  };

}
