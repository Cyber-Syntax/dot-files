{ pkgs, ... }:
{
  boot = {
    #TODO: Testing suspend problem on qtile with this option
      #kernelParams = [ "nvidia-drm.modeset=1" ];
    kernelPackages = pkgs.linuxPackages_latest; # Use latest stable Linux
    loader = {
      systemd-boot = {
        enable = true;
        #timeout = 5;
        #defaultKernelOptions = [ "quiet" ];
        configurationLimit = 50;
      };

      efi = {
        canTouchEfiVariables = true;
        #systemPartition = "/boot";
      };
    };

    # reno cubic enabled: 83-89down 18-19up
    # after bbr enabled: 89-93down 18-20up
    kernelModules = ["tcp_bbr"]; # Enable BBR congestion control algorithm.
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq";
      "net.core.wmem_max" = 104857000; # 100Mib
      "net.core.rmem_max" = 104857000; # 100Mib
      "net.ipv4.tcp_rmem" = "4096 87380 104857000"; # 4Kib 87Kib 100Mib
      "net.ipv4.tcp_wmem" = "4096 87380 104857000"; # 4Kib 87Kib 100Mib
    };
      
  };

}
