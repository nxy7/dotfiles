{ pkgs, ... }: {
  home.packages = with pkgs; [
    sassc
    (python311.withPackages (p: [ p.python-pam ]))
  ];
  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = ./.;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [ libsoup_3 papirus-icon-theme ];
  };
}
