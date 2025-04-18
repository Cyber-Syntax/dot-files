# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6041139f-30e7-4df3-8301-636da6fdd92a";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/2ae63646-2e12-45c6-9113-748f9f571c72";
    fsType = "ext4";
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/b3d10b34-ffb6-4d33-b996-e1e46f9f19aa";
    fsType = "ext4";
    neededForBoot = true;
    options = ["noatime"]; # "x-initrd.mount" -> already added by default
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E7E7-6FD1";
    fsType = "vfat";
    options = [
      "noatime"
      "fmask=0137"
      "dmask=0027"
    ];
  };

  fileSystems."/mnt/backups" = {
    device = "/dev/disk/by-uuid/4c491a88-7501-4b9c-acce-802cfa7b8e1b";
    fsType = "btrfs";
    options = [
      "nofail"
      "noatime"
      "defaults"
    ];
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp34s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
