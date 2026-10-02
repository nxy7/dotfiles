{ pkgs, ... }:
{
  networking.hostName = "g5-runner";
  time.timeZone = "Europe/Warsaw";
  # The release the laptop was first installed with (as the desktop), not the
  # current one. It sets defaults for on-disk state; don't bump it.
  system.stateVersion = "23.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ------------------------------------------------------------
  # Always-on, lid-closed laptop
  # ------------------------------------------------------------

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # Never suspend or hibernate, whatever asks for it.
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  # Blank and power down the built-in panel after a minute on the console.
  boot.kernelParams = [ "consoleblank=60" ];

  # It sits on AC permanently; a battery held at 100% for months swells.
  # Not every firmware exposes a charge limit, so the unit skips itself when
  # the file is missing (check with `systemctl status battery-charge-limit`).
  systemd.services.battery-charge-limit = {
    description = "Cap battery charge at 80% for always-on AC use";
    wantedBy = [ "multi-user.target" ];
    unitConfig.ConditionPathExistsGlob = "/sys/class/power_supply/BAT*/charge_control_end_threshold";
    serviceConfig.Type = "oneshot";
    script = ''
      for f in /sys/class/power_supply/BAT*/charge_control_end_threshold; do
        echo 80 > "$f"
      done
    '';
  };

  services.fstrim.enable = true;
  zramSwap.enable = true;

  # ------------------------------------------------------------
  # Network: Ethernet, with Wi-Fi as fallback
  # ------------------------------------------------------------

  # DHCP on every interface. dhcpcd gives wireless routes a higher metric, so
  # traffic uses the cable whenever it's plugged in.
  networking.useDHCP = true;

  # The password lives in /var/lib/wireless/secrets on the machine (see
  # fleet/README.md), never in the Nix store or this repo.
  networking.wireless = {
    enable = true;
    secretsFile = "/var/lib/wireless/secrets";
    networks."NETIASPOT-47CD-5G".pskRaw = "ext:home_psk";
  };

  # g5-runner.local on the LAN.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  # Only SSH is open (the openssh module opens its own port).
  networking.firewall.enable = true;

  # ------------------------------------------------------------
  # Access
  # ------------------------------------------------------------

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEfw129RbcelQ2YzNNqBqdU3AtUeblkTMRxrkpKlOHBB danielukd@gmail.com"
    ];
  };

  # Login is key-only. Passwordless sudo lets `nixos-rebuild --sudo` deploy
  # from the Mac.
  security.sudo.wheelNeedsPassword = false;

  # ------------------------------------------------------------
  # Nix
  # ------------------------------------------------------------

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # admin already has passwordless root; this lets deploys copy paths in.
    trusted-users = [
      "root"
      "admin"
    ];
    # CI fills the store fast. When a build finds less than 20 GiB free, the
    # daemon collects garbage until 50 GiB is free.
    min-free = 20 * 1024 * 1024 * 1024;
    max-free = 50 * 1024 * 1024 * 1024;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise.automatic = true;

  environment.systemPackages = with pkgs; [
    git
    htop
    vim
    curl
    jq
  ];
}
