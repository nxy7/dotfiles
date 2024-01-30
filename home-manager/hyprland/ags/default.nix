{ pkgs, inputs, config, ... }: rec {
  home.packages = with pkgs; [
    sassc
    brightnessctl
    (python311.withPackages (p: [ p.python-pam ]))
  ];

  home.file.".local/share/ags/colors.json".text =
    builtins.toJSON config.colorScheme.palette;

  programs.ags = {
    enable = true;
    package = inputs.ags.packages.${pkgs.system}.default;

    configDir = ./.;

    extraPackages = with pkgs; [ libsoup_3 papirus-icon-theme ];
  };
}
