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
    i3lock
    picom
    xdotool # command for mouse binds etc.
  ];

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "qtile_udev";
      text = ''
        ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.qtile-unwrapped}/bin/qtile udev --group wheel backlight --device %k"
        ACTION=="add", SUBSYSTEM=="leds",      RUN+="${pkgs.qtile-unwrapped}/bin/qtile udev --group wheel backlight --device %k"
        ACTION=="add" KERNEL=="thinkpad_acpi" RUN+="${pkgs.qtile-unwrapped}/bin/qtile udev --group wheel battery"
      '';
      destination = "/etc/udev/rules.d/99-qtile.rules";
    })
  ];

  services = {
    # udev.enable = true;
    # udev.extraRules = ''
    # '';

    displayManager = {
      defaultSession = "qtile";
      autoLogin.enable = true; # NOTE: ctrl + alt + F1,2,3,4 still works
      autoLogin.user = "developer";

      sddm = {
        enable = true;
        autoNumlock = true;
        #TEST: theme testing
        theme = "where_is_my_sddm_theme";
      };
    };

    xserver = {
      enable = true;
      xkb.layout = "tr";
      autorun = true;
      exportConfiguration = true;

      windowManager.qtile = {
        enable = true;
        extraPackages =
          python3Packages: with python3Packages; [
            qtile-extras
          ];
      };

    }; # ./xserver
  }; # ## ./services
}
