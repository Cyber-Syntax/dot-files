import os
from libqtile.lazy import lazy
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from functions import send_left, send_right, focus_left_mon, focus_right_mon, cycle_groups, cycle_groups_reverse

## Keybindings ##
mod = "mod4"              # Sets mod key to SUPER/WINDOWS

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button1", lazy.window.bring_to_front()),
]

keys = [
    ## APPS ##
        # terminal
            Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
        # brave browser
            Key([mod], "less", lazy.spawn(os.path.expanduser("~/Documents/appimages/appman_apps/brave/brave")), desc="Launch brave"),
        # siyuan
            Key([mod], "s", lazy.spawn(os.path.expanduser("~/Documents/appimages/siyuan.AppImage")), desc="Launch siyuan"),
        # folder
            Key([mod], "z", lazy.spawn("pcmanfm"), desc="Launch pcmanfm"),
        # custom spotify via chromium `chromium --user-data-dir=.config/spotify --app=https://open.spotify.com/`
            Key([mod], "v", lazy.spawn("chromium --user-data-dir=.config/spotify --app=https://open.spotify.com/"), desc="Launch spotify"),

    ## Custom Rofi Scripts ##
        Key([mod], "r", lazy.spawn(os.path.expanduser("~/.config/rofi/launchers/type-3/launcher.sh")), desc="Spawn a command using a prompt widget"),
        Key([mod], "x", lazy.spawn(os.path.expanduser("~/.config/rofi/powermenu/type-2/powermenu.sh")), desc="Spawn a command using a prompt widget"),
        Key([mod], "m", lazy.spawn("pactl set-default-sink $(pactl list short sinks |awk '{print $2}' | rofi -dmenu)"), desc="Spawn a command using a prompt widget"),

    ## i3lock ##
        Key([mod], "l", lazy.spawn("i3lock"), desc="Lock the screen"),

    ## Qtile Controls ##
        Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        #Key([mod], "l", lazy.next_layout(), desc="Toggle between layouts"),
        Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
        Key([mod], "t", lazy.window.toggle_floating(), desc='toggle floating'),
        Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),
        Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Change layout
        Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
        
    
    # Switch focus of windows
     ## 1 window setup
        # ## focus window up or down
        # Key([mod], 'd',     lazy.layout.down()),
        # Key([mod], 'a',     lazy.layout.up()),
        # ## change window location up or down
        # Key([mod], 'w',  lazy.layout.shuffle_down()),
        # Key([mod], 'e',  lazy.layout.shuffle_up()),
        
        ## Change focus of windows when layout is Max
        #Key([mod, "shift"], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
        ## cycle through the groups with the same screen_affinity
        Key([mod], "Tab", cycle_groups),

        Key([mod, "shift"], "Tab", cycle_groups_reverse),

    ### Multimedia keys
        Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
        Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%")),
        Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%")),
        Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
        Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
        Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),

        ## 2 monitor setup
        Key([mod], "w", send_left),
        Key([mod], "e", send_right),
        Key([mod], "a", focus_left_mon),
        Key([mod], "d", focus_right_mon),
        Key([mod], "l", lazy.prev_screen(), desc="Move focus to right"),
        Key([mod], "j", lazy.next_screen(), desc="Move focus to right"),
        #  (tilde) " = keycode 49 (keysym 0x22, quotedbl)
        # use xev to find the keycode of the key
        Key([mod], 49, lazy.layout.down(), desc="Move focus down"),
]
