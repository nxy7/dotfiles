{ pkgs, ... }: {
  services.gvfs.enable = true;
  security.polkit.enable = true;
  # service exposed on port 14564
  services.goxlr-utility = { enable = true; };
  # systemd.services.goxlr = {
  #   enable = true;
  #   description = "GoXLR Utility";
  #   unitConfig = { };
  #   serviceConfig = {
  #     User = "nxyt";
  #     ExecStart = "${pkgs.goxlr-utility}/bin/goxlr-daemon";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  #   # ...
  # };

}
