{ pkgs, ... }: {
  home.packages = with pkgs; [
    # vivaldi
    ungoogled-chromium
    firefox
    brave
  ];

  # xdg.mimeApps.enable = true;
  # xdg.mimeApps.defaultApplications = {
  #   "text/html" = [ "firefox.desktop" "firefox-developer-edition.desktop" ];
  #   "text/xml" = [ "firefox.desktop" "firefox-developer-edition.desktop" ];
  # };
  # programs.firefox = {
  #   enable = true;
  #   package = pkgs.firefox-devedition-unwrapped;
  # };
}
