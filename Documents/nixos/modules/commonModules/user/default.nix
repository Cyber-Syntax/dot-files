{
  users.users.developer = {
    isNormalUser = true;
    description = "developer";
    extraGroups = [
      # "backlight"
      "networkmanager"
      "wheel"
      "libvirtd"
      "video"
      "kvm"
    ];
  };
}
