{
  pkgs,
  ...
}:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ../visuals
    ../nixos
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    settings.trusted-users = [
      "root"
      "nxyt"
    ];
    optimise.automatic = true;

    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 15d";
    };
  };
  hardware.keyboard.qmk.enable = true;
  environment = {
    variables.EDITOR = "hx";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      # DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
      LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "0";
      QT_QPA_PLATFORM = "wayland";
      MESA_VK_DEVICE_SELECT = "10de:28a0";
    };
  };
  fonts.fontconfig.enable = true;
  programs.dconf.enable = true;

  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "16G";
    MemoryMax = "20G";
    CPUQuota = "400%";
  };

  environment.systemPackages = with pkgs; [
    # via
    qmk-udev-rules
  ];
  services = {
    xserver.xkb.layout = "pl,pl";

    flatpak.enable = true;
    resolved.enable = true;
    udev.packages = [ pkgs.via ];

    printing.enable = true;
  };

  environment.shells = with pkgs; [
    # fish
    nushell
    # elvish
  ];

  time.hardwareClockInLocalTime = true;
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
  security.rtkit.enable = true;

  virtualisation.docker = {
    enable = true;
    # autoPrune = true;
    liveRestore = false;
  };

  environment.etc."containers/policy.json".text = builtins.readFile ./policy.json;

  system.stateVersion = "23.11";
}
