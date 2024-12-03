{ pkgs, ... }:

{
  # Disable pulseaudio, using pipewire
  hardware.pulseaudio.enable = false;

  # sytemd-timer for trash-cli to delete files older than 30 days.
  systemd.timers."trash-cli" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true; # make systemd timer persistent if missed the last start time, similar anacron
    };
  };

  systemd.services."trash-cli" = {
    # (crontab -l ; echo "@daily $(which trash-empty) 30") | crontab -
    script = ''
      ${pkgs.trash-cli}/bin/trash-empty 30  
    '';

    serviceConfig = {
      Type = "oneshot";
      #ExecStart = "${pkgs.trash-cli}/bin/trash-empty 30";
      User = "developer";
    };
  };

  services = {

    clamav = {
      updater.enable = true;
      updater.settings = {
        LogVerbose = true;
      };
      updater.interval = "hourly";
    };

    openssh = {
      enable = false;
      startWhenNeeded = true;
      settings.PermitRootLogin = "no"; # prohibit-password
      settings.PasswordAuthentication = false;

      openFirewall = true; # default
      # ports = [ 
      #   22 
      # ];
      # settings.AllowUsers = [
      #
      # ];
      # settings.Macs = [
      #   # Allowed Macs
      #   # "hmac-sha2-512-etm@openssh.com" # example
      # ];
    };

    gnome.gnome-keyring.enable = true;
    acpid.enable = true;
    dbus.enable = true;
    devmon.enable = true;
    printing.enable = false;
    fstrim.enable = true;
    fwupd.enable = true;
    smartd.enable = true;

    # Fuse filesystem support like bash '/bin/bash' 
    # prefer to use env instead of bin
    #TESTING
    envfs.enable = true;

    # Sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

  };
}
