{...}: {
  ### NETWORK
  networking = {
    # Enable the NetworkManager
    networkmanager.enable = true;
    # Define your hostname.
    #TESTING:
    hosts = {
      "192.168.1.60" = ["nextcloud"];
      "192.168.1.107" = ["laptop"];
      "192.168.1.39" = ["nixos"];
      "192.168.1.58" = ["phone"];
    };

    ### FIREWALL
    firewall = {
      enable = true;
      allowPing = false; # decline ICMP pings

      # allow syncthing
      allowedTCPPorts = [
        8384
        22000
      ];
      allowedUDPPorts = [
        22000
        21027
      ];
      # allowedUDPPortRanges = [
      #   { from = 4000; to = 4007; }
      #   { from = 8000; to = 8010; }
      # ];
      #iptables -D nixos-fw -p tcp --source 192.0.2.0/24 --dport 1714:1764 -j nixos-fw-accept || true
      # iptables -A nixos-fw -p udp --source 192.168.1.107 --dport 1:65535 -j nixos-fw-accept || true # SiYuan
      # iptables -A nixos-fw -p tcp --source 192.168.1.107 --dport 1:65535 -j nixos-fw-accept || true
      #TESTING: Enable ssh only from local machines (192.168.1.39/24)
      #TEST: test this command is it reject or not, use the below as example if it's not:
      #iptables -I nixos-fw -p tcp --source 192.168.1.39 --dport 22 -j nixos-fw-accept || true
      #NOTE: ssh disabled for now
      # reject 22 port which is ssh
      #iptables -A INPUT -p tcp --dport 22 -j REJECT
      #enable if working remotely
      #iptables -I INPUT -p tcp --dport 22 -j ACCEPT
      #TODO: after test, enable eextraCommands from machines nix settings
      #iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
      extraCommands = ''
        # Set default chain policies
        iptables -P INPUT DROP # if this is remote, this will disconnect from ssh
        iptables -P FORWARD DROP
        iptables -P OUTPUT ACCEPT

        # Accept on localhost
        iptables -A INPUT -i lo -j ACCEPT
        iptables -A OUTPUT -o lo -j ACCEPT

        # Allow established sessions to receive traffic
        iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

        # Allow SSH from local network (192.168.1.0/24)
        iptables -A INPUT -p tcp --source 192.168.1.0/24 --dport 22 -j ACCEPT

      '';
    };
  };
}
