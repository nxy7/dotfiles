{ pkgs, ... }: {
  home.packages = with pkgs; [
    # browsers
    # vivaldi
    # ungoogled-chromium
    firefox
    # firefox-devedition
    brave
  ];
}
