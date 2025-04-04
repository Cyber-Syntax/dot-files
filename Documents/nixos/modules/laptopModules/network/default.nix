{
  #iptables -A nixos-fw -p udp --source 192.168.1.39 --dport 1:65535 -j nixos-fw-accept || true
  networking = {
    hostName = "nixosLaptop";

    #TODO: Enable after default 22 port is rejected
    #iptables -A INPUT -p tcp -s 192.168.1.39/24 --dport 22 -j ACCEPT
    # firewall = {
    #   extraCommands = ''
    #     iptables -I INPUT -p tcp --dport 22 -s 192.168.1.39 -j ACCEPT
    #   '';
    # };
  };
}
