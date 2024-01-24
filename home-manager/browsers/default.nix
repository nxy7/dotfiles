{ pkgs, ... }: {
  home.packages = with pkgs; [
    vivaldi
    ungoogled-chromium
    brave
    firefox-devedition
  ];
  # programs.firefox = {
  #   enable = true;
  #   package = pkgs.firefox-devedition-unwrapped;
  # };
}
