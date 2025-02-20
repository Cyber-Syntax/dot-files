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

  #NVIDIA + Hyprland
  #FIX: modesetting not building for nvidia?
  #NOTE: hyprland works for now but below boot kernel params needed for modesetting
  boot = {
    #NOTE: If you encounter the problem of booting to text mode you might try adding the Nvidia kernel module manually with:
    # initrd.kernelModules = [ "nvidia" ];
    # extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

    # Check: /etc/modules-load.d/nixos.conf
    extraModprobeConfig = ''
      options nvidia-drm modeset=1
    '';

    kernelParams = [
      "nvidia.NVreg_CheckPCIConfigSpace=0"
      "nvidia.NVreg_EnablePCIeGen3=1"
      "nvidia.NVreg_UsePageAttributeTable=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia_drm.modeset=1"
    ];

    kernelModules = [
      #NOTE: seems like this is used for closed source driver?
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    #   extraModprobeConfig =
    #     "options nvidia "
    #     + lib.concatStringsSep " " [
    # nvidia assume that by default your CPU does not support PAT,
    # but this is effectively never the case in 2023
    #       "NVreg_UsePageAttributeTable=1"
    # This is sometimes needed for ddc/ci support, see
    # https://www.ddcutil.com/nvidia/
    #
    # Current monitor does not support it, but this is useful for
    # the future
    #       "NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100"
    #   ];
  };

  services = {
    displayManager = {

      #TODO: delete (Hyprland systemd sesion) from ssddm which it is cause blank screen

      defaultSession = "hyprland";
      autoLogin.enable = true; # ctrl + alt + F1,2,3,4 still works
      autoLogin.user = "developer";

      sddm = {
        enable = true;
        autoNumlock = true;
        # theme = "where_is_my_sddm_theme";
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

  environment.variables = {
    # Required to run the correct GBM backend for nvidia GPUs on wayland
    GBM_BACKEND = "nvidia-drm";
    # Hardware cursors are currently broken on nvidia
    WLR_NO_HARDWARE_CURSORS = "1";

    #Default wayland variables
    # WLR_RENDERER = "vulkan"; # I don't play games
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_SCALE_FACTOR = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    WLR_DRM_DEVICES = "/dev/dri/card1"; # before = "/dev/dri/card1:/dev/dri/card0"
    CLUTTER_BACKEND = "wayland";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";

    #nixos_ozone already handle this
    # ELECTRON_OZONE_PLATFORM_HINT = "auto"; # for obsidian etc.

    #disable hardware Acceleration on electron base app which cause issue on obsidian?
    # Workaround, disable hardware Acceleration by their app settings
    # NOTE: solved on obsidian and don't see any problem on FreeTube now.
    # ELECTRON_DISABLE_HARDWARE_ACCELERATION = "1";
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
    egl-wayland

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
    #FIX: flameshot not work on wayland
    #TESTING: grimshot
    grim # screenshots
    slurp # screenshots
    grimblast
    #FIX: gammastep not work?

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
