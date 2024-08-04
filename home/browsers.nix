{ pkgs, ... }: {
  home.packages = with pkgs;
    [
      # browsers
      # vivaldi
      # ungoogled-chromium
      # firefox-devedition
      brave
    ];

  # programs.firefox = {
  #   enable = true;
  #   # nativeMessagingHosts.tridactyl = true;
  #   nativeMessagingHosts = { tridactyl = true; };
  # };
}
