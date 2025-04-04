{
  networking = {
    hostName = "nixos";

    #TODO: Enable after default 22 port is rejected
    # firewall = {
    #   extraCommands = ''
    #     iptables -I INPUT -p tcp --dport 22 -s 192.168.1.107 -j ACCEPT
    #   '';
    # };
  };
}
