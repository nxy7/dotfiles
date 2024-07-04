{ pkgs, ... }: {
  home.packages = with pkgs; [
    # browsers
    vivaldi
    # ungoogled-chromium
    # firefox
    brave
  ];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };
}
