{ config, pkgs, unstablepkgs, ... }: {
  imports = [ /etc/nixos/hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  boot.loader.systemd-boot.enable = true;
  boot.kernelParams = [
    "cgroup_no_v1=all"
    "cgroup_enable=memory"
    "cgroup_enable=cpuset"
    # "cgroup_memory=1"
    "systemd.unified_cgroup_hierarchy=1"
  ];

  # kernel patches are required for Cilium to work correctly
  boot.kernelPatches = [{
    name = "nft-custom-config";
    patch = null;
    extraConfig = ''
      NFT_SOCKET m
      NFT_TPROXY m
      NETFILTER_XT_TARGET_TPROXY m
      NETFILTER_XT_TARGET_CT m
      NETFILTER_XT_MATCH_MARK m
      NETFILTER_XT_MATCH_SOCKET m
    '';
  }];
  services.k3s.enable = false;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    "--disable-kube-proxy"
    "--disable=traefik"
    # "--disable=coredns"
    "--flannel-backend=none"
    "--disable-network-policy"
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv6l-linux" ];
  time.hardwareClockInLocalTime = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    53
    80
    443
    2379
    2380
    4240
    4244
    4245
    4250
    4251
    6060
    6061
    6062
    6081
    6443
    8132
    8132
    8133
    8181
    8472
    9443
    9878
    9879
    9890
    9891
    9893
    9962
    9963
    9964
    10250
  ];
  networking.firewall.allowedUDPPorts =
    [ 53 80 443 4789 6081 6443 8132 8181 8472 51871 ];

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

  # without this NixOS cannot hibernate properly
  security.protectKernelImage = false;

  boot.kernelPackages = unstablepkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  networking.extraHosts = ''
    172.17.0.2 streampaiz.pl
  '';

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
      # gdm is causing some issues after restart and with autologin
      # gdm.enable = true;
      # gdm.nvidiaWayland = true;
      autoLogin = {
        enable = true;
        user = "nxyt";
      };
    };
    desktopManager.gnome.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
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
  # --config-file="${
  #   pkgs.writeText "daemon.json" (builtins.toJSON {
  #     ipv6 = true;
  #     fixed-cidr-v6 = "fd00::/80";
  #   })
  # virtualisation.docker.extraOptions = "";

  services.flatpak.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
  };
  programs.gamemode.enable = true;

  system.stateVersion = "22.11";

}
