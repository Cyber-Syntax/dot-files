{
  config,
  pkgs,
  lib,
  ...
}:
#TODO: Can't work when you want to change something in qtile config.
# It's get the .config files and send it to store but it won't allow you to change it.
# It won't let qtile .py files, it is directly linked to the store to main config files.
# ! Do not forget to change autostart bash script location
# "~/Documents/nixos/home-manager/qtile/scripts/autostart.sh"
# With this, I can easily manage 2 different qtile config
# for multiple users.
{
  home-manager.users.developer.home.file.qtile_config = {
    #NOTE: I think this is probably need to be qtile or something else like path.
    source = ./src; # create src folder and send it there your configs
    target = "Documents/nixos/hosts/desktop/qtile"; # Could be .config/qtile
    recursive = true;
  };
}
