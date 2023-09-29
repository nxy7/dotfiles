{ config, pkgs, unstablepkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./kernel.nix
    ./firewall.nix
    ./packages.nix
    (import ./users.nix pkgs unstablepkgs)
    ./programs.nix
    ./udev.nix
  ];

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  time.hardwareClockInLocalTime = true;
  environment.shells = with unstablepkgs; [ nushell ];

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
  services.xserver = {
    enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = "nxyt";
      };
    };
    desktopManager.gnome.enable = true;
  };

  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };

  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.package = unstablepkgs.docker_24;
  virtualisation.docker.extraOptions = ''
    --insecure-registry "http://noxy.ddns.net:5000"
    }"'';

  system.stateVersion = "22.11";
}
