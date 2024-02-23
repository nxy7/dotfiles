{ pkgs, ... }: {
  home.packages = with pkgs; [
    # vivaldi
    # ungoogled-chromium
    firefox
    brave
  ];
}
