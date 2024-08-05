{ pkgs, ... }:
{
  gtk = {
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      # Prefer Dark Theme
      color-scheme = "prefer-dark";
      # Configure Battery Icon in GNOME
      #show-battery-percentage = true;
    };
    
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "trayIconsReloaded@selfmade.pl"
          "Vitals@CoreCoding.com"
          "dash-to-panel@jderose9.github.com"
          "sound-output-device-chooser@kgshank.net"
          "space-bar@luchrioh"
          "pop-shell@system76.com"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];        
    };

    # "org/gnome/desktop/peripherals/touchpad" = {
    #   # Configure Touchpad in GNOME
    #   disable-while-typing = false;
    # };
  };
  home.packages = [
    pkgs.gnomeExtensions.appindicator # App Indicator
    pkgs.gnomeExtensions.clipboard-history # Clipboard History
  ];
}
