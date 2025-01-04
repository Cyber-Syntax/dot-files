import os
from libqtile.lazy import lazy

# TESTING: clear imports
from libqtile.config import Click, Drag, Key


## Keybindings ##
mod = "mod4"  # Sets mod key to SUPER/WINDOWS

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button1", lazy.window.bring_to_front()),
]

keys = [
    ## APPS ##
    # terminal
    Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
    # brave browser
    # Key([mod], "less", lazy.spawn(os.path.expanduser("~/Documents/appimages/appman_apps/brave/brave")), desc="Launch brave"),
    # firefox
    Key([mod], "less", lazy.spawn("firefox"), desc="Launch firefox"),
    # siyuan
    # Key([mod], "s", lazy.spawn(os.path.expanduser("~/Documents/appimages/siyuan.AppImage")), desc="Launch siyuan"),
    # folder
    Key([mod], "z", lazy.spawn("pcmanfm"), desc="Launch pcmanfm"),
    # custom spotify via chromium `chromium --user-data-dir=.config/spotify --app=https://open.spotify.com/`
    # Key([mod], "v", lazy.spawn("chromium --user-data-dir=.config/spotify --app=https://open.spotify.com/"), desc="Launch spotify"),
    ## Custom Rofi Scripts ##
    Key(
        [mod],
        "r",
        lazy.spawn(os.path.expanduser("~/.config/rofi/launchers/type-3/launcher.sh")),
        desc="Spawn a command using a prompt widget",
    ),
    Key(
        [mod],
        "x",
        lazy.spawn(os.path.expanduser("~/.config/rofi/powermenu/type-6/powermenu.sh")),
        desc="Spawn a command using a prompt widget",
    ),
    Key(
        [mod],
        "m",
        lazy.spawn(
            "pactl set-default-sink $(pactl list short sinks |awk '{print $2}' | rofi -dmenu)"
        ),
        desc="Spawn a command using a prompt widget",
    ),
    ## i3lock ##
    Key([mod], "l", lazy.spawn("i3lock"), desc="Lock the screen"),
    ## Qtile Controls ##
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "l", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="toggle floating"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="toggle fullscreen"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Change layout
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    # Switch focus of windows
    # lazy.screen.prev_group(skip_empty=True),
    # 1 monitor setup
    # cycle groups on 1 monitor setup
    Key([mod], "Tab", lazy.screen.next_group(), desc="Move to next group"),
    Key([mod, "shift"], "Tab", lazy.screen.prev_group(), desc="Move to previous group"),
    # Cycle only if there are window in the group (e.g skip empty groups)
    Key([mod], 49, lazy.screen.next_group(skip_empty=True), desc="Move to next group"),
    # Key([mod, "shift"], "Tab", lazy.screen.prev_group(skip_empty=True), desc="Move to previous group"),
    # focus window up or down
    Key([mod], "d", lazy.layout.down()),
    Key([mod], "a", lazy.layout.up()),
    # change window location up or down
    Key([mod], "w", lazy.layout.shuffle_down()),
    Key([mod], "e", lazy.layout.shuffle_up()),
    # ## 2 monitor setup
    # Key([mod], "Tab", cycle_groups),
    # Key([mod, "shift"], "Tab", cycle_groups_reverse),
    #     Key([mod], "w", send_left),
    #     Key([mod], "e", send_right),
    #     Key([mod], "a", focus_left_mon),
    #     Key([mod], "d", focus_right_mon),
    # #  (tilde) " = keycode 49 (keysym 0x22, quotedbl)
    # # use xev to find the keycode of the key
    #     Key([mod], 49, lazy.layout.down(), desc="Move focus down"),
    # Multimedia keys
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%"),
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%"),
    ),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
]

# Change focus of windows when layout is Max
# Key([mod, "shift"], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
# cycle through the groups with the same screen_affinity
