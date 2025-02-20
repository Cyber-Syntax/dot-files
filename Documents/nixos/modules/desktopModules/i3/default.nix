{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.setxkbmap
    xorg.xrandr
    xorg.xhost
    xorg.xev
    xorg.xkbcomp
    xorg.xkill
    xorg.xwininfo
    xorg.xinit
    xorg.xauth
    xorg.xinit
    xorg.xcbutil
    xorg.libxcb
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxkbfile
    xorg.libxshmfence
    i3lock
    picom
    xdotool # command for mouse binds etc.
    jq
  ];
  # i3 configuration
  environment.pathsToLink = [ "/libexec" ]; # Links /libexec from derivations to /run/current-system/sw

  # Configure keymap in X11
  services = {
    # udev.enable = true;
    # udev.extraRules = ''
    # '';

    displayManager = {
      defaultSession = "none+i3";
      autoLogin.enable = true; # ctrl + alt + F1,f2... still works
      autoLogin.user = "developer";

      sddm = {
        enable = true;
        autoNumlock = true;
        # theme = "where_is_my_sddm_theme";
        wayland.enable = false;
      };

    };

    xserver = {
      enable = true;
      xkb.layout = "tr";
      autorun = true;
      exportConfiguration = true;
      # displayManager.lightdm.enable = true;

      desktopManager = {
        xterm.enable = false;
      };

      windowManager.i3 = {
        enable = true;
        # Shell commands executed just before i3 is started.
        # extraSessionCommands = "" ""; # strings concatenated with "\n"
        extraPackages = with pkgs; [
          i3lock
          polybar
        ];
      };

    }; # ./xserver
  }; # ## ./services

}
