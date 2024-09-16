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
    };
  };
  fonts.fontconfig.enable = true;
  services.flatpak.enable = true;
  programs.dconf.enable = true;

  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "20G";
    MemoryMax = "28G";
  };

  environment.etc."containers/policy.json".text =
    builtins.readFile ../policy.json;
  environment.systemPackages = with pkgs; [ via qmk-udev-rules ];
  services.udev.packages = [ pkgs.via ];

  imports = with ./modules; [
    # inputs.agenix.nixosModules.default
    /etc/nixos/hardware-configuration.nix
    ./modules/kernel.nix
    ./modules/firewall.nix
    ./modules/samba.nix
    ./modules/vpn.nix

    #/modules display
    ./modules/fonts.nix
    ./modules/gaming.nix
    ./modules/gnome.nix
    #/modules ./hyprland.nix
    # ./modules/cosmic.nix
    # ./modules/kde.nix

    ./modules/audio.nix

    ./modules/packages.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/programs.nix
    ./modules/udev.nix
  ];

  time.hardwareClockInLocalTime = true;
  environment.shells = with pkgs; [ fish nushell elvish ];

  nixpkgs.config.allowUnfree = true;

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
  virtualisation.docker.package = pkgs.docker_27;
  virtualisation.docker.extraOptions = ''
    --insecure-registry "http://noxy.ddns.net:5000"
    }"'';

  system.stateVersion = "23.11";
}
