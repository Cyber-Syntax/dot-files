{config, ...}:
#TODO: converting things from hardware-configuration.nix which I wasn't suppose to change anything there...
{
  #performance cause problem with amd 2600x CPU. amd_pstate driver is not supported with this CPU.(Zen+)
  # only zen2 and newer support this amd_pstate driver.
  # TODO: testing common-cpu-amd on flakes
  # cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors
  # performance, powersave on my cpu AMD Ryzen 5 5600X
  powerManagement.cpuFreqGovernor = "performance"; # ondemand, performance, powersave
  #https://github.com/PutinVladimir/zenpower3
  boot.kernelModules = [
    # "amd-pstate" # built-in now, no need module
    "zenpower"
  ];
  boot.kernelParams = [
    "initcall_blacklist=acpi_cpufreq_init"
  ];
  boot.extraModulePackages = [config.boot.kernelPackages.zenpower];
  boot.blacklistedKernelModules = ["k10temp"];
}
