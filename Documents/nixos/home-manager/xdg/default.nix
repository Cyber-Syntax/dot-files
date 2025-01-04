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
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];

      config = {
        common = {
          default = [
            "gtk"
          ];
          "org.freedesktop.impl.portal.FileChooser" = [
            "lxde"
          ];
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
      };
    };

    #TODO: add new defaultApplications:
    #
    # inode/directory
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [
          "org.gnome.Evince.desktop"
          "com.github.xournalpp.xournalpp.desktop"
        ];
        "x-scheme-handler/https" = [
          "firefox.desktop"
          "brave-browser.desktop"
          "chromium-browser.desktop"
        ];
        "image/png" = [
          "feh.desktop"
          "gimp.desktop"
        ];
        "image/jpg" = [
          "feh.desktop"
          "gimp.desktop"
        ];
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
