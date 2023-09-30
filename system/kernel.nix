{ pkgs, lib, config, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_6_5;
  boot.kernelModules = [ "kvm-amd" ];
  security.protectKernelImage = false;

  zramSwap = {
    enable = true;
    algorithm = "lz4";
  };

  boot.loader.systemd-boot.enable = true;
  boot.kernelParams = [
    "cgroup_no_v1=all"
    "cgroup_enable=memory"
    "cgroup_enable=cpuset"
    "systemd.unified_cgroup_hierarchy=1"
  ];

  boot.kernelPatches = [{
    name = "nft-custom-config";
    patch = null;
    extraStructuredConfig = {
      NFT_SOCKET = lib.kernel.module;
      NFT_TPROXY = lib.kernel.module;
      NETFILTER_XT_TARGET_TPROXY = lib.kernel.module;
      NETFILTER_XT_TARGET_CT = lib.kernel.module;
      NETFILTER_XT_MATCH_MARK = lib.kernel.module;
      NETFILTER_XT_MATCH_SOCKET = lib.kernel.module;
      NETFILTER_XT_SET = lib.kernel.module;
      IP_SET = lib.kernel.module;
      IP_SET_HASH_IP = lib.kernel.module;
      BPF = lib.kernel.yes;
      BPF_SYSCALL = lib.kernel.yes;
      NET_CLS_BPF = lib.mkForce lib.kernel.yes;
      BPF_JIT = lib.mkForce lib.kernel.yes;
      NET_CLS_ACT = lib.mkForce lib.kernel.yes;
      NET_SCH_INGRESS = lib.mkForce lib.kernel.yes;
      CRYPTO_SHA1 = lib.mkForce lib.kernel.yes;
      CRYPTO_USER_API_HASH = lib.mkForce lib.kernel.yes;
      CGROUPS = lib.mkForce lib.kernel.yes;
      CGROUP_BPF = lib.mkForce lib.kernel.yes;
      PERF_EVENTS = lib.mkForce lib.kernel.yes;
      SCHEDSTATS = lib.mkForce lib.kernel.yes;
    };
  }];

  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv6l-linux" ];
}
