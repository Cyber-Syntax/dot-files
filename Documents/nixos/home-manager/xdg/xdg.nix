{ pkgs, ... }:

{
  home-manager.users.developer.xdg = {
      enable = true;
      mime = {
        enable = true;
      };
      
      portal = {
        enable = true;
          xdgOpenUsePortal = true; # resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers.
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
          ];
          
          config = {
            common = {
              default = [
                "gtk"
              ];
            };          
          };
      };

      mimeApps = {
        enable = true;
      };

      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
}
