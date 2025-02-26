{...}: {
  imports = [
    #TODO: test later
    # ./libvirt
    ./nvidia
    ./ollama
    ./amd-cpu.nix
    ./packages
    ./corsair
    # ./qtile
    # ./awesome
    ./hyprland-desktop.nix
  ];
}
