{ pkgs, ... }: {
  home.packages = with pkgs; [ zen-browser-specific ungoogled-chromium brave ];
}
