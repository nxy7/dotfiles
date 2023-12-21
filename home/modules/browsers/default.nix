{ pkgs, ... }: {
  home.programs = with pkgs; [ vivaldi ungoogled-chromium brave ];
}
