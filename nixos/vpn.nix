{ pkgs, config, ... }: {
  # programs.openvpn3.enable = true;
  environment.systemPackages =
    (with pkgs; [ strongswan networkmanager_strongswan ]);
  services.openvpn.servers = {
    # fullstack = { config = "config /root/nixos/openvpn/fullstackVPN.ovpn"; };
  };

  services.strongswan = {
    enable = true;
    connections = {
      fullstack = {
        keyexchange = "ikev2";
        type = "tunnel";
        # leftfirewall = "yes";
        left = "%any";
        # leftcert = "${USERNAME}Cert.pem";
        leftcert = "/home/nxyt/certs/client.crt";
        leftauth = "eap-tls";
        leftid =
          "%nixos"; # use the hostname of your machine with % character prepended. Example: %"client";
        right =
          "azuregateway-252a8e7a-35b7-4c65-a530-3cc6f2c11bee-d537aa23682e.vpn.azure.com";
        # rightid =
        #   "%any"; # Azure VPN gateway FQDN with % character prepended. Example: %azuregateway-xxx-xxx.vpn.azure."com";
        # rightauth = "eap-tls";
        # rightcert = "/home/nxyt/certs/VpnServerRoot.cer_0";
        rightid =
          "%azuregateway-252a8e7a-35b7-4c65-a530-3cc6f2c11bee-d537aa23682e.vpn.azure.com"; # Azure VPN gateway FQDN with % character prepended. Example: %azuregateway-xxx-xxx.vpn.azure."com";
        rightsubnet = "0.0.0.0/0";
        # leftsourceip = "%config";
        auto = "add";
        esp = "aes256gcm16";

        # remote.ca.cacerts = [ "/home/nxyt/certs/ca.crt" ];
      };
    };
    secrets =
      [ "/home/nxyt/certs/client.key" "/home/nxyt/certs/clientcert.pfx" ];
    ca = {
      strongswan = {
        # cacert = "strongswanCert.pem";
        crluri = "http://crl2.strongswan.org/strongswan.crl";
        auto = "add";
      };
      fullstack = {
        auto = "add";
        cacert = "/home/nxyt/certs/ca.crt";
        # crluri = "http://crl2.strongswan.org/strongswan.crl";
      };
      digi = {
        auto = "add";
        # cacert = "/home/nxyt/certs/digicert.crt";
        # crluri = "https://cacerts.digicert.com/DigiCertTLSECCP384RootG5.crt";
        crluri = "https://cacerts.digicert.com/DigiCertGlobalCA-1.crt";
      };
      digiIntermidiate = {
        auto = "add";
        crluri = "https://cacerts.digicert.com/DigiCertSHA2SecureServerCA.crt";
      };
    };
    setup = { strictcrlpolicy = "no"; };

  };

}
