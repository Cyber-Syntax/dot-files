{ pkgs, ... }:
#TODO: use ags or eww ?
# bar setup:
# https://github.com/iSparsh/gross
# https://github.com/saimoomedits/eww-widgets/blob/main/README.md
# https://github.com/Aylur/dotfiles

#TODO: hyprland plugins
#https://hyprland.org/plugins/
{

  #TODO: https://discourse.nixos.org/t/guide-to-installing-qt-theme/35523/2
  # if qt theme needed on wayland

  # If systemd not work:
  # xserver = {
  #   enable = true;
  #   xkb.layout = "tr";
  #   autorun = true;
  #   exportConfiguration = true;
  # }; # ./xserver
  services = {
    displayManager = {
      #TODO: delete hyprland systemd sesion which it is cause blank screen
      # defaultSession = "hyprland";
      autoLogin.enable = true; # NOTE: ctrl + alt + F1,2,3,4 still works
      autoLogin.user = "developer";

      sddm = {
        enable = true;
        autoNumlock = true;
        theme = "where_is_my_sddm_theme";
        wayland.enable = true;
      };
    };
  };

  programs = {
    hyprland.enable = true;
    waybar.enable = true;
    hyprland.xwayland.enable = true;
    #NOTE: swaylock work like a charm for now.
    # hyprlock.enable = true;
    #NOTE: If you use the Home Manager module, make sure to disable the systemd integration, as it conflicts with uwsm.
    # uwsm.enable = true;
    # uwsm.waylandCompositors = {
    #   hyprland = {
    #     prettyName = "Hyprland";
    #     comment = "Hyprland compositor managed by UWSM";
    #     binPath = "/run/current-system/sw/bin/Hyprland";
    #   };
    # };
    # hyprland.withUWSM = true;
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # # Enable wayland for chromium-based apps (VSCode Discord Brave)
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    # WLR_NO_HARDWARE_CURSORS = "1";
  };
  environment.systemPackages = with pkgs; [
    waybar
    eww # bar
    swaybg # setting up wallpaper
    wl-clipboard
    cliphist # Wayland clipboard manager
    swaylock-effects # lockscreen
    swayidle
    rofi-wayland
    libnotify
    # mako # notifications
    kanshi # auto-configure display outputs
    # wdisplays # Graphical application for configuring displays in Wayland compositors
    wlr-randr # Xrandr clone for wlroots compositors
    wev # Wayland event viewer
    #TESTING: bluetooth extension already handle this?
    blueberry # A wrapper application to use gnome-bluetooth outside of GNOME.
    # gtk3 themes
    gsettings-desktop-schemas
    # screen brightness
    brightnessctl
    # grim # screenshots
    #wtype # xdtool alternative
    # pamixer # Pulseaudio command line mixer

    # needed for kde file chooser on wayland
    libsForQt5.qt5.qtwayland
    # libsForQt5.dolphin # dolphin is so big, don't bother with it on laptop
    #later if needed
    # kdePackages.dolphin
    # kdePackages.qtwayland
  ];

  xdg = {
    portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };
  };
  fonts = {
    packages = with pkgs; [
      flat-remix-icon-theme # for hyprland
    ];
  };
}
