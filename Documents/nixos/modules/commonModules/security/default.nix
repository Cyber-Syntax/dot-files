{ pkgs, lib, ... }:
{

  #FIX: gnome keyring still not works
  #https://github.com/NixOS/nixpkgs/issues/86884#issuecomment-1134787613
  environment.systemPackages = with pkgs; [
    python312Packages.keyring
    libgnome-keyring
    gnome-keyring
    # libsForQt5.polkit-kde-agent
    # libsForQt5.kwallet
    # libsForQt5.kwalletmanager
  ];

  # systemd = {
  #   user.services.polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };

  # services.gnome.core-utilities.enable = true;
  # services.gnome.core-os-services.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.at-spi2-core.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false; # Need proper research to make it work
    settings = {
      default-cache-ttl = 2592000;
      max-cache-ttl = 2592000;
    };
  };

  # services.power-profiles-daemon.enable = lib.mkForce false;
  security = {
    # https://www.reddit.com/r/NixOS/comments/lsbo9a/people_using_sshagent_how_do_you_unlock_it_on/?context=3
    pam = {
      services = {
        gdm-password.enableGnomeKeyring = true;
        sddm = {
          # kwallet.package = pkgs.libsForQt5.kwallet-pam;
          enableGnomeKeyring = true;
          # enableKwallet = true;
          gnupg.enable = true;
        };
        login = {
          # kwallet.package = pkgs.libsForQt5.kwallet-pam;

          enableGnomeKeyring = true;
          # enableKwallet = true;
          gnupg.enable = true;
        };
        # kwallet = {
        #   # kwallet.package = pkgs.libsForQt5.kwallet-pam;
        #   name = "kwallet";
        #   enableKwallet = true;
        # };
      };
    };
    rtkit.enable = true;
    polkit.enable = true;

    #Increase password timeout for sudo
    # Allow access on other tty's
    sudo.extraConfig = ''
      Defaults timestamp_type=global
      Defaults env_reset,timestamp_timeout=10
    '';
  };
}
