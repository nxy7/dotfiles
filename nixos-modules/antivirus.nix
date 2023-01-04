{ ... }: {
  services.clamav = {
    scanner.enable = true;
    daemon.enable = false;
    daemon.settings = { LogTime = true; };
    updater.enable = false;
    updater.interval = "daily";
  };
}
