{ pkgs, ... }:

{
  # systemd.user.targets.qtile-session = {
  #     description = "Qtile compositor session";
  #     documentation = [ "man:systemd.special(7)" ];
  #     bindsTo = [ "graphical-session.target" ];
  #     wants = [ "graphical-session-pre.target" ];
  #     after = [ "graphical-session-pre.target" ];
  #   };

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
