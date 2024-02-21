{ pkgs, ... }: {

  home.packages = [ pkgs.activitywatch ];
  systemd.user.services.activitywatch = {
    Unit = {
      Description = "Activity Watch service";
      PartOf = [ "graphical-session.target" ];
      # WantedBy = [ "graphical-session.target" ];
      # After = [ "network-online.target" "graphical-session-pre.target" ];
      # Requires = [ "network-online.target" ];
    };

    # Service configuration
    Service = {
      ExecStart = "${pkgs.activitywatch}/bin/aw-server";
      Restart = "always";
      # Environment = "DISPLAY=:0";
    };
  };

}
