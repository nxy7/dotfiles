{ config, pkgs, inputs, ... }: {
  services.xserver.xkb.layout = "pl,pl";
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.trusted-users = [ "root" "nxyt" ];

    optimise.automatic = true;
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 15d";
    };
  };
  hardware.keyboard.qmk.enable = true;
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
      LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "0";
      QT_QPA_PLATFORM = "wayland";
    };
  };
  fonts.fontconfig.enable = true;
  services.flatpak.enable = true;
  programs.dconf.enable = true;

  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "20G";
    MemoryMax = "28G";
  };

  environment.systemPackages = with pkgs; [ via qmk-udev-rules ];
  services.udev.packages = [ pkgs.via ];

  imports = [
    /etc/nixos/hardware-configuration.nix
    ../nixos-modules/gnome.nix

    ../nixos-modules/kernel.nix
    ../nixos-modules/antivirus.nix
    ../nixos-modules/firewall.nix
    ../nixos-modules/samba.nix
    ../nixos-modules/vpn.nix

    #/modules display
    ../nixos-modules/fonts.nix
    ../nixos-modules/gaming.nix

    ../nixos-modules/audio.nix

    ../nixos-modules/packages.nix
    ../nixos-modules/services.nix
    ../nixos-modules/users.nix
    ../nixos-modules/programs.nix
    ../nixos-modules/udev.nix
  ];

  time.hardwareClockInLocalTime = true;
  environment.shells = with pkgs; [ fish nushell elvish ];

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  services.printing.enable = true;
  security.rtkit.enable = true;

  virtualisation.waydroid.enable = true;

  virtualisation.docker.enable = true;

  environment.etc."containers/policy.json".text =
    builtins.readFile ../policy.json;

  system.stateVersion = "23.11";
}
