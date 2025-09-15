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

  nix.settings = {
    # Necessary for using flakes on this system
    experimental-features = "nix-command flakes";

    # Automatic GC triggered by disk pressure rather than by a clock. When a
    # build finds less than min-free available, the daemon collects garbage
    # mid-build until max-free is free again. This is the backstop that stops
    # a nixpkgs bump from being the thing that fills the disk.
    min-free = 20 * 1024 * 1024 * 1024;
    max-free = 50 * 1024 * 1024 * 1024;
  };

  # Weekly sweep of old generations. Without this, every `nhs`/`nss` switch
  # pins one more full closure as a live GC root forever — the store grows
  # monotonically no matter how often you run nix-collect-garbage, because
  # nothing is actually garbage while the generation still exists.
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  # Hardlink byte-identical files across store paths. Successive nixpkgs
  # revisions share the overwhelming majority of their content, so this is
  # where the store gets most of its dedup.
  nix.optimise.automatic = true;

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
