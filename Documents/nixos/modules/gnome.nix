{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.gnome = {
    enable = lib.mkEnableOption "Gnome";
  };

  config = lib.mkIf config.gnome.enable {
    environment = {
      systemPackages = with pkgs; [
        morewaita-icon-theme
        qogir-icon-theme
        gnome-extension-manager
        wl-clipboard
      ];

      gnome.excludePackages =
        (with pkgs; [
          # gnome-text-editor
          gnome-photos
          gnome-tour
          gnome-connections
          #snapshot
          gedit
          cheese # webcam tool
          epiphany # web browser
          geary # email reader
          evince # document viewer
          totem # video player
          yelp # Help view
          gnome-font-viewer
        ])
        ++ (with pkgs.gnome; [
          gnome-music
          gnome-characters
          tali # poker game
          iagno # go game
          hitori # sudoku game
          atomix # puzzle game
          gnome-contacts
          gnome-initial-setup
          gnome-shell-extensions
          gnome-maps
        ]);
    };

    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

      
    services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    #hardware.sensor.iio.enable = true; # automatic screen rotation like in mobile phones
    ## ./Gnome some settings ###
    ### fix autologin issue on gdm ###
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
    ### ./fix ###


    programs.dconf.profiles.gdm.databases = [
      {
        settings = {
          "org/gnome/desktop/peripherals/touchpad" = {
            tap-to-click = true;
          };
          "org/gnome/desktop/interface" = {
            cursor-theme = "Qogir";
          };
        };
      }
    ];
  };
}
