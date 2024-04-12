{ pkgs, inputs, config, lib, ... }: rec {
  imports = [
    inputs.ags.homeManagerModules.default
    inputs.astal.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    sassc
    brightnessctl
    (python311.withPackages (p: [ p.python-pam ]))
  ];

  home.file.".local/share/ags/colors.json".text = builtins.toJSON
    (with config.lib.stylix.colors; {
      base00 = base00;
      base01 = base01;
      base02 = base02;
      base03 = base03;
      base04 = base04;
      base05 = base05;
      base06 = base06;
      base07 = base07;
      base08 = base08;
      base09 = base09;
      base0A = base0A;
      base0B = base0B;
      base0C = base0C;
      base0D = base0D;
      base0E = base0E;
      base0F = base0F;
      red = red;
      green = green;
      yellow = yellow;
      blue = blue;
      magenta = magenta;
      orange = orange;
    });

  programs.ags = {
    enable = true;
    package = inputs.ags.packages.${pkgs.system}.default;

    configDir = ./.;

    extraPackages = with pkgs; [ libsoup_3 ];
  };

  programs.astal = {
    enable = true;
    extraPackages = with pkgs; [ libadwaita ];
  };
}
