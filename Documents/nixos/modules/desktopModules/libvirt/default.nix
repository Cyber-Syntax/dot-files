{
  pkgs,
  username,
  ...
}:
#TESTING:
{
  ### Virtulization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  #TODO: setup more detail
  # virtualisation = {
  #   libvirtd = {
  #     enable = true;
  #     qemu = {
  #       package = pkgs.qemu_kvm;
  #       swtpm.enable = true;
  #       ovmf.enable = true;
  #       ovmf.packages = [pkgs.OVMFFull.fd];
  #     };
  #   };
  #   spiceUSBRedirection.enable = true;
  # };

  # users.users.${username}.extraGroups = ["libvirtd"];
  #
  # environment.systemPackages = with pkgs; [
  #   spice
  #   spice-gtk
  #   spice-protocol
  #   virt-viewer
  #   #virtio-win
  #   #win-spice
  # ];

  # home-manager.users.${username} = {
  #   dconf.settings = {
  #     "org/virt-manager/virt-manager/connections" = {
  #       autoconnect = ["qemu:///system"];
  #       uris = ["qemu:///system"];
  #     };
  #   };
  # };
}
