{ pkgs, ... }: {
  # programs.zed-editor = {
  #   enable = true;
  #   package = pkgs.zed-editor;
  # };
  home.packages = with pkgs; [ zed-editor ];
}
