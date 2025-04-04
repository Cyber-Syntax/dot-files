{pkgs, ...}: {
  networking.networkmanager.wifi.powersave = true;

  powerManagement = {
    enable = true;
    powertop.enable = true; # auto tunning on the start
    cpuFreqGovernor = "powersave"; # Default governor for all states
  };

  services = {
    # Keep thermald for thermal management
    thermald.enable = true;

    # Main CPU frequency management service
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
          #TESTING: power, switch balance_power if something goes wrong
          energy_performance_preference = "power";
          platform_profile = "low-power";

          # seems like my cpu can be go 4600 MHz
          scaling_min_freq = 400000; # 400 Mhz
          scaling_max_freq = 1300000; # 1.3GHz
          #TESTING: experimental
          enable_thresholds = true;
          start_threshold = 90;
          stop_threshold = 95;
        };
        charger = {
          governor = "performance";
          turbo = "auto";
          energy_performance_preference = "performance";
          platform_profile = "performance";
        };
      };
    };

    # Optimize process scheduling
    system76-scheduler = {
      enable = true;
      useStockConfig = true;
    };
    # Power saving udev rules
    udev.extraRules = ''
      #   # Enable PCIe ASPM power savings
      SUBSYSTEM=="pci", ACTION=="add", TEST=="power/control", ATTR{power/control}="auto"
    '';
    # # Set charge thresholds (90-95%)
    # SUBSYSTEM=="power_supply", ATTR{manufacturer}=="LENOVO", ATTR{model_name}=="Primary", RUN+="${pkgs.bash}/bin/bash -c 'echo 90 > /sys/class/power_supply/BAT0/charge_start_threshold'"
    # SUBSYSTEM=="power_supply", ATTR{manufacturer}=="LENOVO", ATTR{model_name}=="Primary", RUN+="${pkgs.bash}/bin/bash -c 'echo 95 > /sys/class/power_supply/BAT0/charge_stop_threshold'"

    ## Whitelist WiFi from PCIe power saving
    # ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0x2723", ATTR{power/control}="on"
  };

  #NOTE: make sure aspm is supported for pcie_aspm
  # sudo lspci -vv | grep -i 'ASPM.*L1'  # Look for "L1Sub" entries
  boot = {
    kernelParams = [
      # NixOS produces many wakeups per second, which is bad for battery life.
      # This kernel parameter disables the timer tick on the last 4 cores
      "nohz_full=4-7"
      # Power management
      "intel_pstate=active"
      "processor.max_cstate=5"
      "intel_idle.max_cstate=9"

      # Energy performance
      "power.efficient_workqueue=1"
      "sched_energy=1"
      # Enable power saving features
      "pcie_aspm=force"
      "i915.enable_dc=2" # Display C-states (power savings)
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
      "i915.enable_guc=2"
      "i915.enable_dpcd_backlight=1"
      "mem_sleep_default=deep"
      # the USB bluetooth device has autosuspend enabled after boot or after suspend/resume. tlp-stat -u shows:
      "btusb.enable_autosuspend=0"
    ];
    # # Whitelist WiFi adapter from ASPM
    # "pcie_port_pm=off"

    # Intel CPU power saving modules
    kernelModules = [
      "acpi_call"
    ];
  };

  environment.systemPackages = with pkgs; [
    intel-gpu-tools # For Intel GPU power management
    s-tui
  ];
  # Enable display power saving features
  services.xserver = {
    desktopManager.xterm.enable = false; # I think this is default set to false on new state version above 19.09
    #FIX: not works...
    serverFlagsSection = ''
      Option "Backlight" "intel_backlight"
      Option "RegistryDwords" "EnableBrightnessControl=1"
      Option "DPM" "true"
      Option "PowerSave" "true"
      Option "BlankTime" "300"
      Option "StandbyTime" "600"
      Option "SuspendTime" "900"
      Option "OffTime" "1200"
    '';
  };
}
