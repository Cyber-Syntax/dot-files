import os
import subprocess

from libqtile import bar, qtile
from libqtile.config import Screen
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.popup.toolkit import (
    PopupRelativeLayout,
    PopupSlider,
    PopupText,
)
import os
import subprocess
import gi

# Add GTK dependencies
try:
    gi.require_version("Gtk", "3.0")
    from gi.repository import Gtk
    GTK_THEME = Gtk.Settings.get_default().get_property("gtk-icon-theme-name")
    GTK_THEME_AVAILABLE = True
except (ImportError, ValueError):
    GTK_THEME = None
    GTK_THEME_AVAILABLE = False
    print("Warning: Could not load GTK, falling back to default icon theme")

from libqtile import bar, qtile
# Rest of your imports...

import colors

# # TESTING: add button
# from modules.spawn_default_app import spawn_default_app
from variables import *

terminal = "kitty"  # guess if None
colors = colors.Nord


class WidgetTweaker:
    def __init__(self, func):
        self.format = func


@WidgetTweaker
def currentLayout(output):
    return output.capitalize()


# qtile extras setup
VOLUME_NOTIFICATION = PopupRelativeLayout(
    width=200,
    height=50,
    hide_on_mouse_leave=True,
    controls=[
        PopupText(
            text="Volume:",
            name="text",
            pos_x=0.1,
            pos_y=0.1,
            height=0.2,
            width=0.8,
            v_align="middle",
            h_align="center",
        ),
        PopupSlider(
            name="volume",
            pos_x=0.1,
            pos_y=0.3,
            width=0.8,
            height=0.8,
            colour_below="00ffff",
            bar_border_size=2,
            bar_border_margin=1,
            bar_size=4,
            marker_size=0,
            end_margin=0,
        ),
    ],
)

decorations = {
    "BorderDecoration": {
        "border_width": widget_decoration_border_width,
        "colour": widget_decoration_border_color
        + format(int(widget_decoration_border_opacity * 255), "02x"),
        "padding_x": widget_decoration_border_padding_x,
        "padding_y": widget_decoration_border_padding_y,
    },
    "PowerLineDecoration": {
        "path": widget_decoration_powerline_path,
        "size": widget_decoration_powerline_size,
        "padding_x": widget_decoration_powerline_padding_x,
        "padding_y": widget_decoration_powerline_padding_y,
    },
    "RectDecoration": {
        "group": True,
        "filled": True,
        "colour": widget_decoration_rect_color
        + format(int(widget_decoration_rect_opacity * 255), "02x"),
        "line_width": widget_decoration_rect_border_width,
        "line_colour": widget_decoration_rect_border_color,
        "padding_x": widget_decoration_rect_padding_x,
        "padding_y": widget_decoration_rect_padding_y,
        "radius": widget_decoration_rect_radius,
    },
}

decoration = [getattr(widget.decorations, widget_decoration)(**decorations[widget_decoration])]

widget_defaults = dict(
    font=bar_font,
    foreground=bar_foreground_color,
    fontsize=bar_fontsize,
    padding=widget_padding,
    decorations=decoration,
)

extension_defaults = widget_defaults.copy()

sep = [widget.WindowName(foreground="#00000000", fmt="", decorations=[])]
left_offset = [widget.Spacer(length=widget_left_offset, decorations=[])]
right_offset = [widget.Spacer(length=widget_right_offset, decorations=[])]
space = widget.Spacer(length=widget_gap, decorations=[])


# def no_text(text):
#     return ""

def smart_parse_text(text):
    """
    Display cleaned up text for applications without icons,
    but hide text for applications with working icons.
    """
    # List of applications with working icons
    apps_with_icons = ["firefox", "chromium", "chrome", "nemo", "nautilus", "kitty", "terminal"]
    
    # List of applications without working icons that need text
    apps_without_icons = ["zed", "some-other-app"]
    
    # Clean up common suffixes
    for suffix in [" - Firefox", " - Chromium", " - Mozilla Firefox", " — Mozilla Firefox"]:
        text = text.replace(suffix, "")
        
    # Check if this window belongs to an app that has a working icon
    for app in apps_with_icons:
        if app.lower() in text.lower():
            return ""  # Hide text, show only icon
            
    # Check if this is an app we know doesn't have a working icon
    for app in apps_without_icons:
        if app.lower() in text.lower():
            return text  # Show text since icon doesn't work
    
    # Default: return shortened text (maybe limited to certain length)
    if len(text) > 30:
        return text[:27] + "..."
    return text



left = [
    # "pyxdg" package is needed for wayland for TaskList
    widget.GroupBox(
        font=f"{bar_font} Bold",
        disable_drag=True,
        borderwidth=0,
        fontsize=15,
        inactive=nord_theme["disabled"],
        active=bar_foreground_color,
        block_highlight_text_color=nord_theme["accent"],
        padding=7,
    ),
    space,
    widget.TaskList(
        border="#414868",  # border clour
        highlight_method="block",
        max_title_with=80,
        txt_minimized="",
        txt_floating="",
        txt_maximized="",
        parse_text=smart_parse_text,
        spacing=1,
        icon_size=20,
        border_width=0,
        fontsize=13,  # Do not change! Cause issue with specified widget_defaults
        stretch=False,
        padding_x=1,
        padding_y=1,
        hide_crash=True,
        # theme_mode="preferred",
        # theme_mode='fallback', #FIX: not work currently
        theme_path=[
            "~/.local/share/icons/"
            "/usr/share/icons/",
            "/usr/share/pixmaps/",
            GTK_THEME
        ],
        decorations=[
            getattr(widget.decorations, widget_decoration)(
                **decorations[widget_decoration] | {"extrawidth": 4}
            )
        ],
    ),
    space,
    # TODO: define default apps, handle groups not find problem
    #    default_apps = ["firefox", "code", "nemo", None, None, "firefox", None, "discord", "pavucontrol", "terminator -e bpytop",]
    # widget.TextBox(
    #     " ",
    #     fontsize=20,
    #     decorations=[
    #         getattr(widget.decorations, widget_decoration)(
    #             **decorations[widget_decoration] | {"extrawidth": 3}
    #         )
    #     ],
    #     mouse_callbacks={
    #         "Button1": lazy.function(
    #             spawn_default_app, groups, default_apps, unset_default_app=run_launcher
    #         ),
    #     },
    # ),
]
middle = []

right = [
    space,
    widget.PulseVolumeExtra(
        fmt="{}",
        decorations=[
            getattr(widget.decorations, widget_decoration)(
                **decorations[widget_decoration] | {"extrawidth": 4}
            )
        ],
        theme_path="/home/developer/.config/qtile/icons/volume/",
        icon_size=20,
        limit_normal=80,
        limit_high=100,
        limit_loud=101,
        mode="both",
        # mouse_callbacks={"Button3": lazy.function(widget.select_sink)},
    ),
    space,
    widget.Mpris2(
        fmt="{}",
        format=" {xesam:title} - {xesam:artist}",
        paused_text="  {track}",
        playing_text="  {track}",
        scroll_fixed_width=False,
        max_chars=200,
        separator=", ",
        stopped_text="",
        width=200,
    ),
    space,
    widget.ThermalSensor(
        tag_sensor="Tctl",
        foreground=colors[4],
        fmt=" {}",
        update_interval=2,
        threshold=60,
        foreground_alert="ff6000",
        mouse_callbacks={
            "Button1": lambda: qtile.spawn(terminal + " htop"),
            "Button3": lambda: qtile.spawn(terminal + " btop"),
        },
    ),
    space,
    widget.NvidiaSensors(
        fmt=" {}",
        format="{temp}°C {fan_speed} {perf}",
        update_interval=2,
        threshold=60,
        foreground_alert="ff6000",
        mouse_callbacks={"Button1": lambda: qtile.spawn(terminal + " watch -n 2 'nvidia-smi'")},
    ),
    space,
    widget.DF(
        update_interval=60,
        partition="/",
        format="({uf}{m}|{r:.0f}%)",
        fmt=" {}",
        measure="G",  # G,M,B
        warn_space=4,  # warn if only 5GB or less space left
        visible_on_warn=True,
    ),
    space,
    widget.DF(
        update_interval=60,
        partition="/home",
        format="({uf}{m}|{r:.0f}%)",
        fmt=" {}",
        warn_space=20,
        visible_on_warn=True,
    ),
    space,
    widget.DF(
        update_interval=60,
        partition="/mnt/backups",
        format="({uf}{m}|{r:.0f}%)",
        fmt=" {}",
        warn_space=10,
        visible_on_warn=True,
    ),
    space,
    # custom script caller widget
    widget.GenPollText(
        func=lambda: subprocess.check_output(
            "/home/developer/.config/qtile/scripts/fedora-flatpak-status.sh", timeout=15, shell=True
        )
        .decode("utf-8")
        .strip(),
        update_interval=3600,  # Update every 60 minutes
        mouse_callbacks={
            "Button1": lambda: qtile.spawn(
                'kitty -- bash -c "/home/developer/.config/qtile/scripts/update-dnf-flatpak.sh"'
            ),
        },
    ),
    space,
    widget.Clock(
        format="%A %d %B %Y %H:%M",
        mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')},
    ),
    space,
    # widget.StatusNotifier(),
    # NOTE: Systray would not able to handle transparent background some of the apps.
    widget.Systray(
        decorations=[
            getattr(widget.decorations, widget_decoration)(
                **decorations[widget_decoration] | {"extrawidth": 4}
            )
        ],
    ),
    space,
    widget.CurrentLayoutIcon(
        padding=10,
        scale=0.6,
    ),
    space,
    widget.TextBox(
        "⏻",
        fontsize=20,
        decorations=[
            getattr(widget.decorations, widget_decoration)(
                **decorations[widget_decoration] | {"extrawidth": 3}
            )
        ],
        mouse_callbacks={
            # "Button1": lazy.spawn(powermenu)
            "Button1": lazy.spawn(
                os.path.expanduser("~/.config/rofi/powermenu/type-6/powermenu.sh")
            ),
        },
    ),
    space,
]

screens = [
    Screen(
        top=bar.Bar(
            widgets=left_offset + left + sep + middle + sep + right + right_offset,
            size=bar_size,
            background=bar_background_color + format(int(bar_background_opacity * 255), "02x"),
            margin=[
                bar_top_margin,
                bar_right_margin,
                bar_bottom_margin - layouts_margin,
                bar_left_margin,
            ],
            opacity=bar_global_opacity,
        ),
    ),
]
