{ config, pkgs, inputs, ... }: {
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.trusted-substituters =
      [ "https://ai.cachix.org" "https://nix-community.cachix.org" ];
    settings.trusted-public-keys =
      [ "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc=" ];
    settings.trusted-users = [ "root" "nxyt" ];

    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };
  hardware.keyboard.qmk.enable = true;
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
    };
  };
  fonts.fontconfig.enable = true;

  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "10G";
    MemoryMax = "12G";
  };

  imports = [
    /etc/nixos/hardware-configuration.nix
    ./kernel.nix
    ./firewall.nix
    ./samba.nix
    ./vpn.nix

    # display
    ./hyprland.nix
    ./fonts.nix
    # ./gnome.nix

    ./audio.nix

    ./packages.nix
    ./services.nix
    (import ./users.nix)
    ./programs.nix
    ./udev.nix
  ];
  environment.etc.test = {
    text = "elo";
    mode = "777";
  };

  environment.etc.someotherfile = {
    text = "elo";
    mode = "777";
  };

  time.hardwareClockInLocalTime = true;
  environment.shells = with pkgs; [ fish nushell ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

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

  # programs.sway.enable = true;
  services.syncthing = {
    enable = true;
    user = "nxyt";
    dataDir = "/home/nxyt/Sync";
    configDir = "/home/nxyt/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
  };

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 7;
  };

  services.printing.enable = true;
  security.rtkit.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.package = pkgs.docker_24;
  virtualisation.docker.extraOptions = ''
    --insecure-registry "http://noxy.ddns.net:5000"
    }"'';

  system.stateVersion = "22.11";
}
