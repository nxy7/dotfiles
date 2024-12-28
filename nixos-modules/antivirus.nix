{ ... }: {
  services.clamav = {
    scanner.enable = true;
    daemon.enable = true;
  };
}
