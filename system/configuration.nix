{ config, pkgs, unstablepkgs, ... }: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    (import ./kernel.nix unstablepkgs)
    ./firewall.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  time.hardwareClockInLocalTime = true;

  environment.systemPackages = with pkgs; [
    lsof
    unzip
    k3s
    obsidian

    zip
    libreoffice-qt
    obs-studio

    xclip
    wl-clipboard
    vlc
    lutris

    vscode

    wget
    usbutils
    alacritty
    git
    helix

    ## browsers
    ungoogled-chromium
    brave
    firefox-devedition-bin
  ];
  environment.shells = with unstablepkgs; [ nushell ];

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.nvidia.modesetting.enable = true;

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

  fonts.fonts = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0xcafe", MODE="0666", GROUP="embeddev", SYMLINK+="picoprobe"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0x303a", MODE="0666", GROUP="embeddev"
    KERNEL=="ttyACM0", MODE="0666", GROUP="embeddev"
    KERNEL=="hidraw7", MODE="0666", GROUP="embeddev"
    KERNEL=="hidraw4", MODE="0666", GROUP="embeddev"
  '';

  users.users.nxyt = {
    isNormalUser = true;
    description = "nxyt";
    extraGroups = [ "networkmanager" "wheel" "docker" "embeddev" ];
    packages = with pkgs; [ discord ];
    shell = unstablepkgs.nushell;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.package = unstablepkgs.docker_24;
  virtualisation.docker.extraOptions = ''
    --insecure-registry "http://noxy.ddns.net:5000"
    }"'';

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;

  system.stateVersion = "22.11";

}
