{ pkgs, ... }: {
  home.packages = with pkgs; [ zen-browser ungoogled-chromium brave ];
}
