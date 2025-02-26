{config, ...}:
#TODO: converting things from hardware-configuration.nix which I wasn't suppose to change anything there...
{
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
