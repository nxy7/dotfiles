unstablepkgs:

{
  boot.kernelPackages = unstablepkgs.linuxPackages_latest;
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
    extraConfig = ''
      NFT_SOCKET m
      NFT_TPROXY m
      NETFILTER_XT_TARGET_TPROXY m
      NETFILTER_XT_TARGET_CT m
      NETFILTER_XT_MATCH_MARK m
      NETFILTER_XT_MATCH_SOCKET m
      NETFILTER_XT_SET m
      IP_SET m
      IP_SET_HASH_IP m
      BPF y
      BPF_SYSCALL y
      NET_CLS_BPF y
      BPF_JIT y
      NET_CLS_ACT y
      NET_SCH_INGRESS y
      CRYPTO_SHA1 y
      CRYPTO_USER_API_HASH y
      CGROUPS y
      CGROUP_BPF y
      PERF_EVENTS y
      SCHEDSTATS y
    '';
  }];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv6l-linux" ];
}
