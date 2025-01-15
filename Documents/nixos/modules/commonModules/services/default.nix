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
      enable = true;
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

    #TEST: Disable uefi update via fwupd
    # environment.etc."fwupd/uefi_capsule.conf" = lib.mkForce {
    #   source = pkgs.writeText "uefi_capsule.conf" ''
    #     [uefi_capsule]
    #     OverrideESPMountPoint=${config.boot.loader.efi.efiSysMountPoint}
    #     DisableCapsuleUpdateOnDisk=true
    #   '';
    # };

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

      #FIX: probably need fix because it's not working
      #NOTE: The best way to get everything working is to keep increasing the quant value until you get no crackles (underruns) or until you get audio again (in case there wasn't any).
      # extraConfig.pipewire."92-low-latency" = {
      #   context.properties = {
      #     "default.clock.rate" = 96000;
      #     "default.clock.quantum" = 512;
      #     "default.clock.min-quantum" = 512;
      #     "default.clock.max-quantum" = 2048;
      #   };
      # };
      #NOTE: As a general rule, the values in pipewire-pulse should not be lower than the ones in pipewire.
      # extraConfig.pipewire-pulse = {
      #   "92-low-latency" = {
      #     context.modules = [
      #       {
      #         name = "libpipewire-module-protocol-pulse";
      #         args = {
      #           pulse.min.req = "512/96000";
      #           pulse.default.req = "512/96000";
      #           pulse.max.req = "2048/96000";
      #           pulse.min.quantum = "512/96000";
      #           pulse.max.quantum = "2048/96000";
      #         };
      #       }
      #     ];
      #     stream.properties = {
      #       node.latency = "512/96000";
      #       resample.quality = 1;
      #     };
      #   };
      # };

    };
  };
  #
  # environment.etc."wireplumber/main.lua.d/99-alsa-lowlatency.lua".text = ''
  #   alsa_monitor.rules = {
  #     {
  #       matches = {{{ "node.name", "matches", "alsa_output.*" }}};
  #       apply_properties = {
  #         ["audio.format"] = "S32LE",
  #         ["audio.rate"] = "96000", -- for USB soundcards it should be twice your desired rate
  #         ["api.alsa.period-size"] = 2, -- defaults to 1024, tweak by trial-and-error
  #         -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
  #       },
  #     },
  #   }
  # '';
}
