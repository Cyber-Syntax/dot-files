{
  pkgs,
  unstable,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Use latest production
    # kernelParams = [ "preempt=full" ];
    loader = {
      systemd-boot = {
        enable = true;
        #defaultKernelOptions = [ "quiet" ];
        configurationLimit = 30;
      };

      efi = {
        canTouchEfiVariables = true;
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
