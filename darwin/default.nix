{ config, pkgs, ... }:

{
  # Set primary user for system defaults
  system.primaryUser = "dawiddanieluk";

  # Set default shell for user
  users.users.dawiddanieluk = {
    shell = pkgs.nushell;
  };

  # Add nushell to available shells
  environment.shells = [ pkgs.nushell ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    nushell
  ];

  services.tailscale.enable = true;
  homebrew = {
    enable = true;
  };

  # Nix itself is installed and managed by Determinate Nix (determinate-nixd),
  # not nix-darwin. nix-darwin refuses to activate while it would fight over
  # the daemon, so its nix.* module is off — which also disables nix.settings,
  # nix.gc and nix.optimise. Their equivalents live below.
  nix.enable = false;

  # Determinate owns /etc/nix/nix.conf and includes nix.custom.conf for user
  # settings. Flakes are on by default in Determinate Nix.
  #
  # Automatic GC triggered by disk pressure rather than by a clock. When a
  # build finds less than min-free available, the daemon collects garbage
  # mid-build until max-free is free again. This is the backstop that stops
  # a nixpkgs bump from being the thing that fills the disk.
  environment.etc."nix/nix.custom.conf".text = ''
    min-free = ${toString (20 * 1024 * 1024 * 1024)}
    max-free = ${toString (50 * 1024 * 1024 * 1024)}
  '';

  # Weekly sweep of old generations. Without this, every `nhs`/`nss` switch
  # pins one more full closure as a live GC root forever — the store grows
  # monotonically no matter how often you run nix-collect-garbage, because
  # nothing is actually garbage while the generation still exists.
  # (Replaces nix.gc; same schedule as its default.)
  launchd.daemons.nix-gc.serviceConfig = {
    ProgramArguments = [
      "/nix/var/nix/profiles/default/bin/nix-collect-garbage"
      "--delete-older-than"
      "7d"
    ];
    StartCalendarInterval = [ { Weekday = 7; Hour = 3; Minute = 15; } ];
    RunAtLoad = false;
  };

  # Hardlink byte-identical files across store paths. Successive nixpkgs
  # revisions share the overwhelming majority of their content, so this is
  # where the store gets most of its dedup.
  # (Replaces nix.optimise; same schedule as its default.)
  launchd.daemons.nix-optimise.serviceConfig = {
    ProgramArguments = [
      "/nix/var/nix/profiles/default/bin/nix"
      "store"
      "optimise"
    ];
    StartCalendarInterval = [ { Weekday = 7; Hour = 4; Minute = 15; } ];
    RunAtLoad = false;
  };

  # Set Git commit hash for darwin-version
  system.configurationRevision = config.system.revision or null;

  # Used for backwards compatibility, please read the changelog before changing
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = "aarch64-darwin";

  # macOS system preferences
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-recents = false;
      tilesize = 48;
    };

    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };

  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
