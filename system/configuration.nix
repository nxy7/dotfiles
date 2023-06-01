{ config, pkgs, betaPkgs, ... }:
# let
#   pkgs = import nixpkgs {
#     config = {
#       allowUnfree = true;
#     };
#   };
# in
{
  imports = [ /etc/nixos/hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.kernelPackages = betaPkgs.linuxPackages_zen;

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # xdg.portal.enable = true;

  services.xserver = {
    enable = true;

    # KDE
    # displayManager.sddm.enable = true;
    # desktopManager.plasma5.enable = true;

    # Gnome
    desktopManager.gnome.enable = true;
    # displayManager.gdm.enable = true;
    # displayManager.gdm.wayland = true;

    # Xfce
    # displayManager.gdm.enable = true;
    # desktopManager.xfce.enable = true;
    # desktopManager.xterm.enable = false;

    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "nxyt";
  };

  # I don't want to use default tools and instead pick them myself
  # services.gnome.core-utilities.enable = false;

  # KDE

  # Gnome

  # services.xserver.displayManager.defaultSession = "gnome";

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # lowLatency = {
    #   # enable this module      
    #   enable = true;
    #   # defaults (no need to be set unless modified)
    #   quantum = 64;
    #   rate = 48000;
    # };

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
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

  # udev rules for embedded development
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0xcafe", MODE="0666", GROUP="embeddev", SYMLINK+="picoprobe"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", MODE="0666"
    KERNEL=="hidraw7", MODE="0666", GROUP="embeddev"
    KERNEL=="hidraw4", MODE="0666", GROUP="embeddev"
  '';

  users.users.nxyt = {
    isNormalUser = true;
    description = "nxyt";
    extraGroups = [ "networkmanager" "wheel" "docker" "embeddev" ];
    packages = with pkgs; [ brave discord firefox-devedition-bin firefox ];
    shell = betaPkgs.nushell;
  };
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    # gnome.gnome-terminal
    gnome.gnome-tweaks
    vlc
    lutris
    vscode
    htop
    ripgrep
    wget
    usbutils
    alacritty
    git
    helix
  ];
  environment.shells = with betaPkgs; [ nushell ];
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

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "22.11";

}
