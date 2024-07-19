{ pkgs, lib, config, minimal ? false, ... }:
let
  base = {
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
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelParams = [
      "cgroup_no_v1=all"
      "cgroup_enable=memory"
      "cgroup_enable=cpuset"
      "systemd.unified_cgroup_hierarchy=1"

      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
  };

  extras = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.graphics = { enable = true; };
    boot.extraModulePackages = with config.boot.kernelPackages;
      [ v4l2loopback ];
    hardware.opentabletdriver.enable = true;
    services.xserver.wacom.enable = true;

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      open = false;
      powerManagement.enable = true;
      nvidiaSettings = true;
      modesetting.enable = true;
    };
  };

in lib.mkMerge [ base extras ]

