{ config, pkgs, unstablepkgs, inputs, ... }: {
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };
  hardware.keyboard.qmk.enable = true;
  environment = {
    sessionVariables = {
      # NIXOS_OZONE_WL = "1";
    };
  };
  fonts.fontconfig.enable = true;

  imports = [
    /etc/nixos/hardware-configuration.nix
    ./kernel.nix
    ./firewall.nix

    # display
    ./hyprland.nix
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

  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  time.hardwareClockInLocalTime = true;
  environment.shells = with unstablepkgs; [ fish nushell ];

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
  };

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 15;
  };

  services.printing.enable = true;
  security.rtkit.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.package = unstablepkgs.docker_24;
  virtualisation.docker.extraOptions = ''
    --insecure-registry "http://noxy.ddns.net:5000"
    }"'';

  system.stateVersion = "22.11";
}
