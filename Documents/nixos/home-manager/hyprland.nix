# home-manager hyprland setup

{
  wayland.windowManager.hyprland = {
    enable = true;

    # systemd setup
    systemd.enable = true;
    systemd.enableXdgAutostart = true;
    systemd.extraCommands = [
        "systemctl --user stop hyprland-session.target"
        "systemctl --user start hyprland-session.target"
    ];
    
    systemd.variables = [
      # "DISPLAY"
      # "HYPRLAND_INSTANCE_SIGNATURE"
      # "WAYLAND_DISPLAY"
      # "XDG_CURRENT_DESKTOP"
      # or
         "--all"
     ];
    # ./systemd # or "systemd"
    xwayland.enable = true;

    # plugins = [
    #   inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
    #   "/absolute/path/to/plugin.so"
    # ];


# # Layouts



    extraConfig = ''
exec-once = asztal  & ~/Documents/appimages/super-productivity.AppImage
exec-once = dunst & gammastep
exec-once=dbus-update-activation-environment DISPLAY I3SOCK SWAYSOCK WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
    exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once=systemctl --user restart xdg-desktop-portal.service
    exec-once=sleep 1 && systemctl --user start xdg-desktop-portal-hyprland

cursor {
    no_hardware_cursors = true
}
## ./ENV variables, Theme, GTK, QT, Nvidia, XDG, Java, SDL ##

### Input, general, decorations, animations, etc. ###
## Keyboard, Mouse
input {
    kb_layout = tr
    kb_variant =
    kb_model = pc105
    kb_options =
    kb_rules =

    follow_mouse = 1
    numlock_by_default = true

    touchpad {
        natural_scroll = no
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

## General, loyout, borders, gaps, tearing, etc.
general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 3
    gaps_out = 0
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)

    layout = dwindle

    # Screen tearing is used to reduce latency and/or jitter in games.(on if you play games)
    allow_tearing = false
}

## Decorations, shadows, animations, etc.
decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 10

    blur {
        enabled = true
        size = 3
        passes = 1
    }

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

## Animations
animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mod + P in the keybinds section below
    preserve_split = yes # you probably want this
}
#
# master {
#     new_is_master = true
# }

gestures {
    workspace_swipe = off
}

misc {
    force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers
}
#
# # Example per-device config
# device:epic-mouse-v1 {
#     sensitivity = -0.5
# }
# ### ./Input, general, decorations, animations, etc. ###

## RULES ##
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    windowrulev2 = float, title:^(Open Folder)
    windowrule = size %50, title:(Open Folder)
    windowrule = float, title:(New Bookmarks — Mozilla Firefox)
    windowrule = size %50, title:(Extension: (Tree Style Tab) - New Bookmarks — Mozilla Firefox)
    windowrule = float, org.kde.polkit-kde-authentication-agent-1
    # rule for idleinhibit for music, videos, nuclearapp
    windowrule = idleinhibit focus, class:(mpv|vlc|nuclear|firefox|chromium|FreeTube)
## ./RULES ##
opengl {
    nvidia_anti_flicker = false
}

   
## MONITORS ##
    monitor=DP-3,1920x1080@60,0x0, 1
    monitor=DP-2,2560x1440@144,1920x0, 1
    #monitor=HDMI-A-1,1366x768@60,4480x0, 1
## ./MONITORS ##
   # Layouts
    workspace = 1, monitor:DP-2, default:true
    workspace = 2, monitor:DP-2, default:true
    workspace = 3, monitor:DP-2, default:true
    workspace = 4, monitor:DP-3, default:true
    workspace = 5, monitor:DP-3, default:true
    workspace = 6, monitor:DP-3, default:true

# # aylur dotfiles keybinds
# bind=$mod_SHIFT, R,  exec, ags -q; ags
 bind=$mod, X,       exec, ags -t launcher
# bind=$mod, X,  exec, ags -t powermenu
# bind=$mod, Tab,     exec, ags -t overview

          # Keybinds
        bind = $mod, Return, exec, kitty # alacritty
        # Keycode 94 = <
        bind = $mod, code:94, exec, brave
        bind = $mod, Z, exec, nautilus
        bind = $mod, S, exec, ~/Documents/appimages/siyuan.AppImage
        bind = $mod, Q, killactive,
        bind = $mod_SHIFT, Q, exit,
        bind = $mod, F, togglefloating,
        bind = $mod, R, exec, wofi --show drun
        # ROFI powermenu.lua
        #bind = $mod, X, exec, ~/.config/rofi/powermenu/type-6/powermenu.sh
        #bind = $mod, M, exec, pactl set-default-sink $(pactl list short sinks |awk "{print $2}" |wofi $wofi_args -dmenu)
        #bind = , F4, exec, ~/.config/waybar/scripts/audio_changer.py
        # swaylock
        bind = $mod_SHIFT, L, exec, swaylock -f -c 000000
        # Send a window to left right monitors
        # movewindow - moves the active window in a specified direction - params: l/r/u/d (left right up down)
        bind = $mod, w, movewindow, l
        bind = $mod, e, movewindow, r
        # Move focus with mod + arrow keys
        bind = $mod, a, movefocus, l
        bind = $mod, d, movefocus, r

        # Screenshot find a wyland screenshot tool
        bind = , Print, exec, grim -g "$(slurp -d)" - | wl-copy
        #bindsym $mod+escape exec killall -s SIGUSR1 swayidle && killall -s SIGUSR1 swayidle
        bind = $mod, F1, exec, killall -s SIGUSR1 swayidle && killall -s SIGUSR1 swayidle

        # Change focus with mod + TAB workspaces respectively
      # TAB = 23
      # " = 49
#        bind = $mod, Tab, workspace, e-1
#        bind = $mod_SHIFT, Tab, workspace, e+1
# Scroll through existing workspaces with mod + scroll
        bind = $mod, mouse_down, workspace, e+1
        bind = $mod, mouse_up, workspace, e-1
        bind = $mod, P, pseudo, # dwindle
        bind = $mod, J, togglesplit, # dwindle
        # Switch workspaces with mod + [0-9]
        bind = $mod, 1, workspace, 1
        bind = $mod, 2, workspace, 2
        bind = $mod, 3, workspace, 3
        bind = $mod, 4, workspace, 4
        bind = $mod, 5, workspace, 5
        bind = $mod, 6, workspace, 6
        bind = $mod, 7, workspace, 7
        bind = $mod, 8, workspace, 8
        bind = $mod, 9, workspace, 9
        bind = $mod, 0, workspace, 10
        # # Move active window to a workspace with mod + SHIFT + [0-9]
    # TODO: test hypr home-manager function, if not work use this:
        # bind = $mod SHIFT, 1, movetoworkspace, 1
        # bind = $mod SHIFT, 2, movetoworkspace, 2
        # bind = $mod SHIFT, 3, movetoworkspace, 3
        # bind = $mod SHIFT, 4, movetoworkspace, 4
        # bind = $mod SHIFT, 5, movetoworkspace, 5
        # bind = $mod SHIFT, 6, movetoworkspace, 6
        # bind = $mod SHIFT, 7, movetoworkspace, 7
        # bind = $mod SHIFT, 8, movetoworkspace, 8
        # bind = $mod SHIFT, 9, movetoworkspace, 9
        # bind = $mod SHIFT, 0, movetoworkspace, 10
    '';


    settings = {
      "$mod" = "SUPER";
      "$altMod" = "ALT";
      "$mod_SHIFT" = "SUPER+SHIFT";

    binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
         # Mediakeys
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioStop, exec, playerctl stop"              
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind =
        [
          "$mod, F, exec, brave"
          ", Print, exec, grimblast copy area"
          "$mod, Enter, exec, kitty"
            # mute
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };
}
