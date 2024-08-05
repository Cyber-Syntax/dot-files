{ config, lib, pkgs, ... }:


{
  # options.hyprland = {
  #   enable = lib.mkEnableOption "Hyprland";
  # };

#config = lib.mkIf config.gnome.enable {
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-wlr
    ];
  };
services.displayManager.defaultSession = "hyprland";
# enable sddm #
  services.displayManager.sddm = {
    enable = true;
    theme = "where-is-my-sddm-theme";
    wayland.enable = true;
    autoNumlock = true;
    settings = {
        Autologin = {
          Session = "hyprland";
          User = "developer"; 
      };
    };
  };

## For hyprland ###
  programs.waybar = {
    enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hyprland packages #
  environment.systemPackages = with pkgs; [
    egl-wayland
    waybar
    wofi
    wl-clipboard
    swayidle # TODO: need to change this to hypridle later
    greetd.tuigreet
    qt5.qtwayland
    slurp
  ];


  environment.sessionVariables = {
   # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # ## ENV variables =  Theme =  GTK =  QT =  Nvidia =  XDG =  Java =  SDL
    # Cursor =  theme
        XCURSOR_SIZE = "30";
        XCURSOR_THEME = "Vimix-white-cursors";
        GTK_THEME = "Materia-dark"; #  # Old: adw-gtk3-dark
    # electron apps
      ELECTRON_OZONE_PLATFORM_HINT = "auto"; # Flickering problem
    # fallback gtk
        GDK_BACKEND = "wayland, x11";
    # XDG environment variables
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
    # Qt environment variables
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_QPA_PLATFORMTHEME = "qt5ct";
    # Nvidia environment variables
        GBM_BACKEND = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        LIBVA_DRIVER_NAME = "nvidia";
        MOZ_ENABLE_WAYLAND = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        SDL_VIDEODRIVER = "wayland";
      #WLR_DRM_NO_ATOMIC=1 - use legacy DRM interface instead of atomic mode setting. Might fix flickering issues.
      };
    #./hyprland #  
  # };
  # # ./config #
}
