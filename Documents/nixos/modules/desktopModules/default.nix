{ ... }:
{
  imports = [
    #TODO: test later
    # ./libvirt
    ./nvidia
    ./ollama
    ./amd-cpu.nix
    ./packages
    ./corsair
    # qtile alternative
    ./qtile
    #default awesome
    ./awesome
  ];
}
