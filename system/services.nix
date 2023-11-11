{ unstablepkgs, ... }: {
  systemd.services.goxlr = {
    enable = true;
    description = "GoXLR Utility";
    unitConfig = {
      # Type = "simple";
      # ...
    };
    serviceConfig = {
      User = "nxyt";
      ExecStart = "${unstablepkgs.goxlr-utility}/bin/goxlr-daemon";
      # ...
    };
    wantedBy = [ "multi-user.target" ];
    # ...
  };

}
