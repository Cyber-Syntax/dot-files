{...}: {
  imports = [
    ./libvirt
    ./nvidia
    ./ollama
    ./amd-cpu
    ./packages
    ./corsair
    ./services #borg and syncthing
    ./network
    # ./WM/hyprland
    # ./WM/awesome
    ./WM/qtile
  ];
}
