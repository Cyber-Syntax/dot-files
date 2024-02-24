import os
from libqtile.lazy import lazy
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from functions import send_left, send_right, focus_left, focus_right

## Keybindings ##
mod = "mod4"              # Sets mod key to SUPER/WINDOWS

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button1", lazy.window.bring_to_front()),
]

keys = [
    ## APPS ##
        # vscode
        Key([mod], "v", lazy.spawn("flatpak run com.visualstudio.code"), desc="vscode"),
        # gnome-terminal
        Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
        # firefox
        Key([mod], "less", lazy.spawn("firefox"), desc="Launch terminal"),
        # siyuan
        Key([mod], "s", lazy.spawn(os.path.expanduser("~/Documents/appimages/siyuan.AppImage")), desc="Launch siyuan"),
        # nautilus
        Key([mod], "z", lazy.spawn("nautilus"), desc="Launch nautilus"),

    ## Custom Rofi Scripts ##
        Key([mod], "r", lazy.spawn(os.path.expanduser("~/.config/rofi/launchers/type-6/launcher.sh")), desc="Spawn a command using a prompt widget"),
        Key([mod], "x", lazy.spawn(os.path.expanduser("~/.config/rofi/powermenu/type-6/powermenu.sh")), desc="Spawn a command using a prompt widget"),
        Key([mod], "m", lazy.spawn("pactl set-default-sink $(pactl list short sinks |awk '{print $2}' | rofi -dmenu)"), desc="Spawn a command using a prompt widget"),

    ## Qtile Controls ##
        Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        Key([mod], "l", lazy.next_layout(), desc="Toggle between layouts"),
        Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
        Key([mod], "t", lazy.window.toggle_floating(), desc='toggle floating'),
        Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),
        Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Change layout
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),

    # Focus, Send windows..
        Key([mod], "w", send_left),
        Key([mod], "e", send_right),
        Key([mod], "a", focus_left),
        Key([mod], "d", focus_right),

        # Change focus of windows when layout is Max
        Key([mod], "Tab", lazy.layout.next(), desc="Move window focus to other window"),

    # Multimedia keys
        Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
        Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
        Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
        Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
        Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
        Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
]
