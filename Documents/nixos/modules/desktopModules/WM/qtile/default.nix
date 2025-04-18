{pkgs, ...}: {
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
    # xorg.libX11
    # xorg.libXScrnSaver
    # xorg.libXcomposite
    # xorg.libXcursor
    # xorg.libXdamage
    # xorg.libXext
    # xorg.libXfixes
    # xorg.libXi
    # xorg.libXrandr
    # xorg.libXrender
    # xorg.libXtst
    # xorg.libxcb
    # xorg.libxkbfile
    # xorg.libxshmfence
    # python312Packages.xcffib
    # python312Packages.cairocffi
    # python312Packages.cffi
    i3lock
    picom
    xdotool # command for mouse binds etc.
    flameshot #screenshot
  ];

  services = {
    # udev.enable = true;
    # udev.extraRules = ''
    # '';

    # libinput.mouse = {
    #   #TESTING:
    #   # accelProfile = "flat"; # slow
    #   #Cursor acceleration (how fast speed increases from minSpeed to maxSpeed).
    #   #This only applies to the flat or adaptive profile.
    #   accelSpeed = "-0.5";
    #   accelStepScroll = 0.1;
    #   #Sets the points of the scroll acceleration function.
    #   accelPointsScroll = [
    #     0.0
    #     1.0
    #     2.4
    #     2.5
    #   ];
    # };

    displayManager = {
      defaultSession = "qtile";
      autoLogin.enable = true; # NOTE: ctrl + alt + F1,2,3,4 still works
      autoLogin.user = "developer";

      # sddm = {
      #   enable = true;
      #   autoNumlock = true;
      #   #TEST: theme testing
      #   theme = "where_is_my_sddm_theme";
      # };
    };

    xserver = {
      enable = true;
      xkb.layout = "tr";
      autorun = true;
      exportConfiguration = true;

      displayManager.lightdm.enable = true;

      windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages:
          with python3Packages; [
            qtile-extras
            pillow
            dbus-next
          ];
      };
    }; # ./xserver
  }; # ## ./services

  #NOTE: laptop only, not used on laptop anymore
  # services.udev.packages = [
  #   (pkgs.writeTextFile {
  #     name = "qtile_udev";
  #     text = ''
  #       ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.qtile-unwrapped}/bin/qtile udev --group wheel backlight --device %k"
  #       ACTION=="add", SUBSYSTEM=="leds",      RUN+="${pkgs.qtile-unwrapped}/bin/qtile udev --group wheel backlight --device %k"
  #       ACTION=="add" KERNEL=="thinkpad_acpi" RUN+="${pkgs.qtile-unwrapped}/bin/qtile udev --group wheel battery"
  #     '';
  #     destination = "/etc/udev/rules.d/99-qtile.rules";
  #   })
  # ];
}
