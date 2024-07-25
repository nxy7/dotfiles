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

  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "30G";
    MemoryMax = "40G";
  };

  environment.etc."containers/policy.json".text =
    builtins.readFile ../policy.json;
  environment.systemPackages = with pkgs; [ via qmk-udev-rules ];
  services.udev.packages = [ pkgs.via ];

  imports = with ./modules; [
    inputs.agenix.nixosModules.default
    /etc/nixos/hardware-configuration.nix
    ./kernel.nix
    ./firewall.nix
    ./samba.nix
    ./vpn.nix

    # display
    ./fonts.nix
    ./gaming.nix
    # ./hyprland.nix
    ./cosmic.nix
    # ./kde.nix

    ./audio.nix

    ./packages.nix
    ./services.nix
    ./users.nix
    ./programs.nix
    ./udev.nix
  ];

  time.hardwareClockInLocalTime = true;
  environment.shells = with pkgs; [ fish nushell elvish ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "pl_PL.UTF-8";

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

  virtualisation.docker.enable = true;
  virtualisation.docker.package = pkgs.docker_27;
  virtualisation.docker.extraOptions = ''
    --insecure-registry "http://noxy.ddns.net:5000"
    }"'';

  system.stateVersion = "23.11";
}
