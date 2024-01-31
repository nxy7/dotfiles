{ pkgs, ... }: {
  # services.systembus-notify.enable = true;
  services.gvfs.enable = true;
  security.polkit.enable = true;
  # service exposed on port 14564
  systemd.services.goxlr = {
    enable = true;
    description = "GoXLR Utility";
    unitConfig = {
      # Type = "simple";
      # ...
    };
    serviceConfig = {
      User = "nxyt";
      ExecStart = "${pkgs.goxlr-utility}/bin/goxlr-daemon";
      # ...
    };
    wantedBy = [ "multi-user.target" ];
    # ...
  };

}
