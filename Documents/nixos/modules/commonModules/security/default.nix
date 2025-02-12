{ pkgs, lib, ... }:
{

  # services.gnome.core-utilities.enable = true;
  # services.gnome.core-os-services.enable = true;
  #FIX: gnome keyring still not works
  #https://github.com/NixOS/nixpkgs/issues/86884#issuecomment-1134787613
  environment.systemPackages = with pkgs; [
    python312Packages.keyring
    libgnome-keyring
    gnome-keyring
  ];
  services.gnome.gnome-keyring.enable = true;
  services.gnome.at-spi2-core.enable = true;

  # services.power-profiles-daemon.enable = lib.mkForce false;
  security = {
    # https://www.reddit.com/r/NixOS/comments/lsbo9a/people_using_sshagent_how_do_you_unlock_it_on/?context=3
    pam = {
      services = {
        gdm-password.enableGnomeKeyring = true;
        sddm = {
          enableGnomeKeyring = true;
          gnupg.enable = true;
        };
        login = {
          enableGnomeKeyring = true;
          gnupg.enable = true;
        };
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
