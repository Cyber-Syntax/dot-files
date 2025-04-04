{
  services = {
    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1; # This is default to 1 but just to be sure
        # Enable debug to see if tlp is working correctly
        #TLP_DEBUG="arg bat disk lock nm path pm ps rf run sysfs udev usb";
        START_CHARGE_THRESH_BAT0 = 90;
        STOP_CHARGE_THRESH_BAT0 = 95;
        # thinkpad drivers
        TPACPI_ENABLE = 1;
        TPSMAPI_ENABLE = 1;

        SCHED_POWERSAVE_ON_BAT = 1;
        SOUND_POWER_SAVE_ON_BAT = 1;

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
        WIFI_PWR_ON_BAT = "on"; # default null
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
        #NOTE:
        # Exclude bluetooth devices from autosuspend mode:
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

        # Runtime PM and ASPM for PCIe/PCI devices (default on AC)
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersave"; # default recommended, powersupersave

        RUNTIME_PM_ON_AC = "auto"; # on, auto --- power consumption / fan noise on AC.
        RUNTIME_PM_ON_BAT = "auto";
        #RUNTIME_PM_DENYLIST="11:22.3 44:55.6"; # deny some device if needed
        # default “mei_me nouveau radeon xhci_hcd” - Version 1.7 and newer
        # RUNTIME_PM_DRIVER_DENYLIST="mei_me nouveau radeon xhci_hcd"
        CPU_SCALING_MIN_FREQ_ON_AC = 400000; # 400 Mhz
        # CPU_SCALING_MAX_FREQ_ON_AC = 9999999; # up to 4.65 Ghz
        CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 1300000; # 1.3 Ghz
        # # 100 - 1250mhz intel gpu
        # looks like this is already defualt
        # INTEL_GPU_MIN_FREQ_ON_AC=100;
        # INTEL_GPU_MIN_FREQ_ON_BAT=100;
        # INTEL_GPU_MAX_FREQ_ON_AC=1250;
        # INTEL_GPU_MAX_FREQ_ON_BAT=1250;
        # INTEL_GPU_BOOST_FREQ_ON_AC=1250;
        # INTEL_GPU_BOOST_FREQ_ON_BAT=1250;

        # # intel_pstate and active mode use this instead cpu_scaling_performance
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 90;
      };
    };
  };
}
