{ pkgs, lib, config, minimal ? false, ... }:
let
  base = {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelModules = [
      "kvm-amd"
      "ip6table_filter"
      "iptable_raw"
      "iptable_nat"
      "iptable_filter"
      "iptable_mangle"
      "ip_set"
      "ip_set_hash_ip"
      "xt_socket"
      "xt_mark"
      "xt_set"
      "v4l2loopback"
    ];
    security.protectKernelImage = false;
    boot.loader.systemd-boot.enable = true;
    boot.kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
      "cgroup_no_v1=all"
      "cgroup_enable=memory"
      "cgroup_enable=cpuset"
      "systemd.unified_cgroup_hierarchy=1"

      # wayland suspend fix
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
    # boot.kernelPatches = [{
    #   name = "nft-custom-config";
    #   patch = null;
    #   extraStructuredConfig = {
    #     NFT_SOCKET = lib.kernel.module;
    #     NFT_TPROXY = lib.kernel.module;

    #     # l7 proxy
    #     NETFILTER_XT_TARGET_TPROXY = lib.kernel.module;
    #     NETFILTER_XT_TARGET_CT = lib.kernel.module;
    #     NETFILTER_XT_MATCH_MARK = lib.kernel.module;
    #     NETFILTER_XT_MATCH_SOCKET = lib.kernel.module;

    #     # cilium ip masquerading
    #     NETFILTER_XT_SET = lib.kernel.module;
    #     IP_SET = lib.kernel.module;
    #     IP_SET_HASH_IP = lib.kernel.module;

    #     # base cilium requirements
    #     BPF = lib.kernel.yes;
    #     BPF_SYSCALL = lib.kernel.yes;
    #     NET_CLS_BPF = lib.mkForce lib.kernel.yes;
    #     BPF_JIT = lib.mkForce lib.kernel.yes;
    #     NET_CLS_ACT = lib.mkForce lib.kernel.yes;
    #     NET_SCH_INGRESS = lib.mkForce lib.kernel.yes;
    #     CRYPTO_SHA1 = lib.mkForce lib.kernel.yes;
    #     CRYPTO_USER_API_HASH = lib.mkForce lib.kernel.yes;
    #     CGROUPS = lib.mkForce lib.kernel.yes;
    #     CGROUP_BPF = lib.mkForce lib.kernel.yes;
    #     PERF_EVENTS = lib.mkForce lib.kernel.yes;
    #     SCHEDSTATS = lib.mkForce lib.kernel.yes;
    #   };
    # }];
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
  };

  extras = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    boot.extraModulePackages = with config.boot.kernelPackages;
      [ v4l2loopback ];
    hardware.opentabletdriver.enable = true;
    services.xserver.wacom.enable = true;

    hardware.nvidia = {
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.42.02";
        sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
        sha256_aarch64 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        persistencedSha256 = lib.fakeSha256;
      };
      open = false;
      powerManagement.enable = true;
      # nvidiaSettings = true;
      # powerManagement.finegrained = false;
      modesetting.enable = true;
    };

    # boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv6l-linux" ];
  };
  # in base // lib.attrsets.optionalAttrs (!minimal) extras
  # in base // extras

in lib.mkMerge [ base extras ]

