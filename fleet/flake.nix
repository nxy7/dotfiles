{
  description = "Raspberry Pi 4 GitHub Actions runner";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }:
    let
      wifiPassword = builtins.getEnv "WIFI_PASSWORD";

      piSystem = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";

        modules = [
          # Bootable Raspberry Pi SD image.
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"

          # Pi 4 hardware profile — correct kernel, firmware, Wi-Fi/BT.
          nixos-hardware.nixosModules.raspberry-pi-4

          ({ pkgs, lib, ... }:
          let
            runnerCount = 2;
            runnerIds = lib.genList (i: i + 1) runnerCount;

            # Shared runner config — each instance gets its own name,
            # systemd service, user, and working directory.  They share
            # only the PAT file and the read-only Nix store.
            #
            # DynamicUser is turned off so runners can be members of the
            # "docker" group and reach the Docker socket.
            mkRunner = id: {
              enable = true;

              url = "https://github.com/nxy7/cogni";

              # Single PAT shared by all runners — GitHub derives a
              # per-runner registration token from it automatically.
              tokenFile = "/var/lib/github-runner-token";

              name = "pi-runner-${toString id}";
              replace = true;          # re-register on restart

              extraLabels = [ "rpi" ];

              # Dedicated user in the docker group.
              user = "runner-${toString id}";
              group = "runners";
              workDir = "/var/lib/github-runner-${toString id}";

              extraPackages = with pkgs; [
                curl
                docker
                jq
              ];

              serviceOverrides = {
                # Allow Docker socket access (incompatible with DynamicUser).
                DynamicUser = lib.mkForce false;
                SupplementaryGroups = [ "docker" ];
              };
            };

            runners = lib.listToAttrs (map (id:
              lib.nameValuePair "cogni-${toString id}" (mkRunner id)
            ) runnerIds);
          in {
            # Fail instead of accidentally building an image with no password.
            assertions = [
              {
                assertion = wifiPassword != "";
                message = "Set WIFI_PASSWORD and build with --impure";
              }
            ];

            # Compress with zstd (fast to decompress on the host).
            sdImage.compressImage = true;

            # The generic sd-image-aarch64 module pulls in initrd modules
            # for Rockchip/Allwinner boards that don't exist in the RPi
            # downstream kernel.  Disable them to unbreak the build.
            boot.initrd.availableKernelModules = {
              dw-hdmi = lib.mkForce false;
              dw-mipi-dsi = lib.mkForce false;
              rockchipdrm = lib.mkForce false;
              rockchip-rga = lib.mkForce false;
              phy-rockchip-pcie = lib.mkForce false;
              pcie-rockchip-host = lib.mkForce false;
              pwm-sun4i = lib.mkForce false;
              sun4i-drm = lib.mkForce false;
              sun8i-mixer = lib.mkForce false;
            };

            # ------------------------------------------------------------
            # Basic system
            # ------------------------------------------------------------

            networking.hostName = "pi-runner";
            time.timeZone = "Europe/Warsaw";

            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];

            zramSwap.enable = true;

            # ------------------------------------------------------------
            # Wi-Fi
            # ------------------------------------------------------------

            networking.wireless = {
              enable = true;

              networks."NETIASPOT-47CD-5G" = {
                psk = wifiPassword;
              };
            };

            networking.useDHCP = true;

            # ------------------------------------------------------------
            # SSH
            # ------------------------------------------------------------

            services.openssh = {
              enable = true;

              settings = {
                PasswordAuthentication = false;
                KbdInteractiveAuthentication = false;
                PermitRootLogin = "no";
              };
            };

            # ------------------------------------------------------------
            # Users
            # ------------------------------------------------------------

            # Dedicated runner users — members of "docker" so they can
            # build/push containers from CI jobs.
            users.groups.runners = {};

            users.users = {
              admin = {
                isNormalUser = true;
                extraGroups = [ "wheel" "docker" ];

                openssh.authorizedKeys.keys = [
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEfw129RbcelQ2YzNNqBqdU3AtUeblkTMRxrkpKlOHBB danielukd@gmail.com"
                ];
              };
            } // lib.listToAttrs (map (id:
              lib.nameValuePair "runner-${toString id}" {
                isSystemUser = true;
                group = "runners";
                extraGroups = [ "docker" ];
                home = "/var/lib/github-runner-${toString id}";
                createHome = true;
              }
            ) runnerIds);

            security.sudo.wheelNeedsPassword = false;

            # Makes pi-runner.local work on your LAN.
            services.avahi = {
              enable = true;
              openFirewall = true;

              publish = {
                enable = true;
                addresses = true;
              };
            };

            # ------------------------------------------------------------
            # GitHub Actions runners (×${toString runnerCount})
            # ------------------------------------------------------------
            #
            # Each runner is a separate systemd service with:
            #   • Dedicated system user (runner-1, runner-2, …)
            #   • Own working directory under /var/lib/github-runner-N
            #   • PrivateTmp=yes    — isolated /tmp
            #   • ProtectHome=yes   — no access to user homes
            #   • Docker access via "docker" group membership
            #
            # DynamicUser is off so runners can reach the Docker socket.

            services.github-runners = runners;

            # Don't continuously fail during first boot because the PAT
            # hasn't been installed yet.
            systemd.services = lib.mapAttrs'
              (name: _: lib.nameValuePair "github-runner-${name}" {
                unitConfig.ConditionPathExists = "/var/lib/github-runner-token";
              })
              runners;

            # ------------------------------------------------------------
            # Docker
            # ------------------------------------------------------------

            virtualisation.docker = {
              enable = true;

              # Weekly prune of dangling images, stopped containers,
              # unused networks, and build cache.
              autoPrune = {
                enable = true;
                flags = [ "--all" "--volumes" ];
              };
            };

            # ------------------------------------------------------------
            # Nix housekeeping
            # ------------------------------------------------------------

            # Weekly GC of old Nix store paths (keeps last 7 days).
            nix.gc = {
              automatic = true;
              options = "--delete-older-than 7d";
            };

            # Hardlink identical files in the store to save space.
            nix.optimise.automatic = true;

            # ------------------------------------------------------------
            # Tools
            # ------------------------------------------------------------

            environment.systemPackages = with pkgs; [
              docker-compose
              docker-buildx
              git
              curl
              jq
              htop
              vim
            ];

            system.stateVersion = "26.05";
          })
        ];
      };
    in {
      nixosConfigurations.pi = piSystem;

      # nix build ./fleet#sdImage --impure
      packages.aarch64-linux.sdImage = piSystem.config.system.build.sdImage;
    };
}
