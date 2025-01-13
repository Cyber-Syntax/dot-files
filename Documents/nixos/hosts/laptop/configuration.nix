{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    #TESTING: migrating the folder hiararchy e.g default.nix
    ./../../modules/commonModules/default.nix

    #TESTING: xdg in test.
    ./../../home-manager/default.nix

    # overlays
    ./../../overlays/default.nix

    # laptop ../../modules
    ./../../modules/laptopModules/intel.nix

  ];

  # Luks encryption support
  boot.initrd.systemd.enable = true;

  # laptop specific packages
  environment.systemPackages = with pkgs; [
    cbatticon # battery icon
  ];

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

  users.users.developer = {
    isNormalUser = true;
    description = "developer";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "video"
      "kvm"
    ];
  };

  # Fix thinkfan issue
  systemd.services.thinkfan.preStart = "
  /run/current-system/sw/bin/modprobe  -r thinkpad_acpi && /run/current-system/sw/bin/modprobe thinkpad_acpi
";

  # TODO: setup hardware for laptop
  # set this if tlp not able to handle it
  #NOTE: if max freq is is 400mhz on battery disable Intel SpeedStep in the BIOS
  # powerManagement.cpuFreqGovernor = "ondemand"; # ondemand, performance, powersave

  services = {
    #NOTE: THIS IS NOT WORKING on i5-13th gen yet
    #NOTE: https://github.com/erpalma/throttled/issues?q=13th
    #TEST: some of the user tested and used but have issue with tlp.

    #TESTING: Lets try to test this one
    throttled.enable = true; # fix for intel cpu throttling on thinkpads

    libinput = {
      enable = true; # for syncaptics touchpads

      touchpad = {
        #tappingButtonMap = "lmr"; # left middle right, this probably not compatible with tapping: "Set the button mapping for 1/2/3-finger taps"
        accelProfile = "adaptive"; # default work for thinkpad for now
        tapping = true;
        #naturalScrolling = true;
        # defualt:true,, pressing the left and right buttons simultaneously produces a middle mouse button click.
        middleEmulation = false;
        scrollMethod = "twofinger";
        disableWhileTyping = true;
        sendEventsMode = "disabled-on-external-mouse";
        tappingDragLock = true; # default, tap and drag like shift behavior on keyboards but this will make it with two tap
        #clickMethod = "buttonareas"; #default: "buttonareas" other: "clickfinger"
      };
    };

    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1; # This is default to 1 but just to be sure
        # Enable debug to see if tlp is working correctly
        #TLP_DEBUG="arg bat disk lock nm path pm ps rf run sysfs udev usb";
        START_CHARGE_THRESH_BAT0 = 85;
        STOP_CHARGE_THRESH_BAT0 = 95;
        # thinkpad drivers
        TPACPI_ENABLE = 1;
        TPSMAPI_ENABLE = 1;

        # sleep mode
        MEM_SLEEP_ON_AC = "s2idle"; # Idle standby, a pure software, light-weight, system sleep state
        MEM_SLEEP_ON_BAT = "deep"; # Suspend to RAM, the whole system is put into a low-power state
        #except for memory, usually resulting in higher savings than s2idle

        # AC balanced to prevent high cpu temp, BAT balanced because powersave is too slow
        PLATFORM_PROFILE_ON_AC = "balanced"; # low-power balanced performance.
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # default performance balance_performance balance_power power
        # #save more balance_power
        # 12th gen and above refuses to activate turbo boost on battery power mode
        #TEST: if turbo boost is not working on battery change to balance_power
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        # 12th gen and above refuses to activate turbo boost on battery
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power"; # balance

        #TESTING: cpu boost maybe decrease scalin_max_freq,
        #if that's happen do not disable this on battery.
        CPU_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_AC = 1;

        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        #NOTE: intel_pstate scaling driver is support only powersave and performance
        #on Sandy Bridge or newer hardwares.
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        #NOTE: wifi powersave 23mbps, AC 30mbps
        #FIXME: remove /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
        WIFI_PWR_ON_BAT = "off"; # default null
        WIFI_PWR_ON_AC = "off";

        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth wwan"; # disable bluetooth and wwan if not in use
        DEVICES_TO_ENABLE_ON_STARTUP = "wifi wwan"; # add bluetooth if cause issue

        DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi wwan";
        DEVICES_TO_DISABLE_ON_WIFI_CONNECT = "wwan";
        DEVICES_TO_DISABLE_ON_WWAN_CONNECT = "wifi";

        DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi wwan";
        DEVICES_TO_ENABLE_ON_WIFI_DISCONNECT = "";
        DEVICES_TO_ENABLE_ON_WWAN_DISCONNECT = "";

        # USB
        #NOTE: Bluetooth devices hang, disconnect or do not pair
        USB_EXCLUDE_BTUSB = 1;
        # if does not disable auto suspend(see tlp-stat -u) than:
        #Solution: add the boot option btusb.enable_autosuspend=0 to your GRUB configuration.

        USB_AUTOSUSPEND = 1; # default 1
        USB_EXCLUDE_AUDIO = 1; # default 1
        USB_EXCLUDE_PHONE = 0; # defaul 0, make it 1 if you want to charge phone
        USB_EXCLUDE_WWAN = 0; # default 0,

        # use max_performance if cause issues
        SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
        SATA_LINKPWR_ON_AC = "max_performance";

        # on – disabled (devices powered on permanently)
        # auto – enabled (power down idle devices)
        # #NOTE: Default is on usage, Change if cause issue on BAT
        #       AHCI_RUNTIME_PM_ON_AC=on;
        #       AHCI_RUNTIME_PM_ON_BAT=auto;
        #       AHCI_RUNTIME_PM_TIMEOUT=15;
        # Newly inserted USB devices are not recognized on battery power
        # Bluetooth, Webcam, and other USB bus devices stop working after switching to battery power
        ## Try one by one, not all of them!!!
        #RUNTIME_PM_DRIVER_DENYLIST="mei_me nouveau radeon xhci_hcd"
        ###Disable runtime power management for AHCI devices an execute tlp start
        # AHCI_RUNTIME_PM_ON_BAT=on
        # RUNTIME_PM_DRIVER_DENYLIST="mei_me nouveau radeon ahci"

        # Runtime PM and ASPM for PCIe/PCI devices (default on AC)
        RUNTIME_PM_ON_AC = "auto"; # on, auto, reduce power consumption / fan noise on AC.
        RUNTIME_PM_ON_BAT = "auto";
        #RUNTIME_PM_DENYLIST="11:22.3 44:55.6"; # deny some device if needed

        #TODO: Later if needed limit power consumtion under high cpu load  with nn < 100 to achieve it.
        # CPU_MAX_PERF_ON_AC=nn;
        # CPU_MAX_PERF_ON_BAT=nn;
        # DEVICES_TO_ENABLE_ON_UNDOCK="wifi";
        # DEVICES_TO_DISABLE_ON_UNDOCK="";

        # wake on lan default is disabled, change to enable if needed
        #WOL_DISABLE = Y; # default is Y-disabled

        # # 100 - 1250mhz intel gpu
        # looks like this is already defualt
        # INTEL_GPU_MIN_FREQ_ON_AC=100;
        # INTEL_GPU_MIN_FREQ_ON_BAT=100;
        # INTEL_GPU_MAX_FREQ_ON_AC=1250;
        # INTEL_GPU_MAX_FREQ_ON_BAT=1250;
        # INTEL_GPU_BOOST_FREQ_ON_AC=1250;
        # INTEL_GPU_BOOST_FREQ_ON_BAT=1250;

        # # intel_pstate and active mode use this instead cpu_scaling_performance
        #   CPU_MIN_PERF_ON_AC=0;
        #   CPU_MAX_PERF_ON_AC=100;
        #   CPU_MIN_PERF_ON_BAT=0;
        #   CPU_MAX_PERF_ON_BAT=90;

      };
    };

    thinkfan = {
      enable = true;
      levels = [
        [
          0
          0
          45
        ]
        [
          1
          43
          48
        ]
        [
          2
          46
          51
        ]
        [
          3
          49
          54
        ]
        [
          4
          51
          60
        ]
        [
          5
          58
          65
        ]
        [
          6
          63
          72
        ]
        [
          7
          70
          82
        ]
        [
          "level full-speed"
          77
          32767
        ]
      ];
    };

    syncthing = {
      enable = true;
      group = "syncthing"; # default
      user = "developer"; # cause permission issues if not set to user
      configDir = "/home/developer/.config/syncthing";
      guiAddress = "127.0.0.1:8384"; # default

      relay.enable = false; # default, syncthing relay server is used via connecting other relay servers. Not local.
      #TODO: is already use this default?
      #relay.listenAddress = "tcp4://:22000" # only ipv4
      systemService = true; # Whether to auto-launch Syncthing as a system service.

      # Whether to delete the folders which are not configured via the folders option. If set to false, folders added via the web interface will persist and will have to be deleted manually.
      overrideFolders = true; # default
      #Whether to delete the devices which are not configured via the devices option. If set to false, devices added via the web interface will persist and will have to be deleted manually.
      overrideDevices = true; # default
      # Note that you can still add folders manually, but those changes will be reverted on restart if overrideFolders is enabled.
      #TODO: Test later after normal syncthing setup via .config.
      # Make sure you use without global discovery server and relay servers.
      # settings.options.localAnnounceEnabled = true; # Whether to send announcements to the local LAN, also use such announcements to find other devices.
      # # TESTING:
      # settings.folders = {
      #   {
      #     "test" = { # looks like folder name for syncthing not path
      #       path = "~/test";
      #       id = "test";
      #       devices = [ "My Phone" ];
      #       type = "sendreceive";
      #       versioning = [
      #         {
      #           versioning = {
      #             type = "simple";
      #             params.keep = "5";
      #           };
      #         }
      #       ];
      #     };#.test folder
      #   }
      # };
      #
      #
      # settings.devices = {
      #   My Phone = {
      #     addresses = [
      #       "tcp://192.168.1.45:22000"
      #     ];
      #     id = "WNMYT36-42FPWK";
      #   };
      # };

      #NOTE: I already setup manually on network but maybe this would be useful
      #openDefaultPorts = true; # open defualt ports if you use one user in this machine.

    }; # ./syncthing

  }; # ./services

  # bluetooth
  services.blueman.enable = true; # gui
  hardware.bluetooth = {
    enable = true;
    #powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket"; # enable A2DP for modern headsets
        # Enabling it may prevent some Bluetooth mice from connecting automatically
        Experimental = true; # show battery charge
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
