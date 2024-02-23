{ pkgs, ... }: {

  home.packages = [ pkgs.activitywatch ];
  systemd.user.services.activitywatch = {
    Unit = {
      Description = "Activity Watch service";
      PartOf = [ "graphical-session.target" ];
    };

    # Service configuration
    Service = {
      ExecStart = "${pkgs.activitywatch}/bin/aw-server";
      Restart = "always";
    };
  };

}
