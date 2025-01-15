from libqtile import bar, qtile
from libqtile.config import Screen

from libqtile.lazy import lazy
import colors
import os
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration

from variables import *

# HACK: mpris2 popup is not working need to fix it later.
# from qtile_extras.popup.templates.mpris2 import COMPACT_LAYOUT, DEFAULT_LAYOUT

colors = colors.Nord


class WidgetTweaker:
    def __init__(self, func):
        self.format = func


@WidgetTweaker
def currentLayout(output):
    return output.capitalize()


# qtile-extras definitions
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

decoration = [
    getattr(widget.decorations, widget_decoration)(**decorations[widget_decoration])
]

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

left = [
    # "pyxdg" package is needed for wayland for TaskList
    widget.TaskList(
        border="#414868",  # border clour
        highlight_method="block",
        # foreground=colors[1],
        # background=colors[0],
        max_title_with=80,
        txt_minimized="",
        txt_floating="",
        txt_maximized="",
        # FIX: get only app names instead of webpage names etc., not work
        # parse_text=lambda text: "|" + text,
        # parse_text=my_func,
        spacing=1,
        icon_size=20,
        border_width=0,
        fontsize=13,  # Do not change! Cause issue with specified widget_defaults
        stretch=False,
        # margin_x=0,
        # margin_y=0,
        padding_x=5,
        padding_y=5,
        hide_crash=True,
        decorations=[
            getattr(widget.decorations, widget_decoration)(
                **decorations[widget_decoration] | {"extrawidth": 4}
            )
        ],
    ),
]

# FIX:
# def my_func(text):
#     for string in [" - Chromium", " - Firefox"]:
#         text = text.replace(string, "")
#     return text


middle = [
    space,
    widget.GroupBox(
        font=f"{bar_font} Bold",
        disable_drag=True,
        borderwidth=0,
        fontsize=15,
        inactive=nord_theme["disabled"],
        active=bar_foreground_color,
        block_highlight_text_color=nord_theme["accent"],
        padding=7,
        # fmt=groupBox,
    ),
]

right = [
    # widget.Volume(
    #     step=2,
    #     fmt=volume,
    #     mouse_callbacks={
    #         "Button1": lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    #     },
    #     update_interval=0.01,
    #     limit_max_volume=True,
    #     volume_app="pavucontrol",
    # ),
    space,
    widget.Mpris2(
        fmt="{}",
        format=" {xesam:title} - {xesam:artist}",
        # foreground=colors[7],
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
        tag_sensor="CPU",
        foreground=colors[4],
        fmt=" {}",
        update_interval=1,
        threshold=60,
        foreground_alert="ff6000",
    ),
    space,
    widget.DF(
        update_interval=60,
        # foreground=colors[5],
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
        # foreground=colors[5],
        partition="/home",
        format="({uf}{m}|{r:.0f}%)",
        fmt=" {}",
        warn_space=20,
        visible_on_warn=True,
    ),
    space,
    widget.DF(
        update_interval=60,
        # foreground=colors[5],
        partition="/nix",
        format="({uf}{m}|{r:.0f}%)",
        fmt=" {}",
        warn_space=20,
        visible_on_warn=True,
    ),
    space,
    widget.DF(
        update_interval=60,
        # foreground=colors[5],
        partition="/backup",
        format="({uf}{m}|{r:.0f}%)",
        fmt=" {}",
        warn_space=10,
        visible_on_warn=True,
    ),
    space,
    widget.Volume(
        fmt="{}",
        emoji=True,
        emoji_list=["🔇", "󰕿 ", "󰖀 ", "󰕾 "],
        fontsize=20,
        # theme_path="/home/developer/.config/qtile/icons/volume",
        check_mute_string="[off]",  # '' icon not working
        mouse_callbacks={
            # Left click to change volume output
            "Button1": lambda: qtile.spawn(
                'kitty -- bash -c "~/.config/qtile/scripts/sink-change.sh --change"'
            ),
            # Right click to open pavucontrol
            "Button3": lambda: qtile.spawn("pavucontrol"),
        },
    ),
    space,
    widget.PulseVolumeExtra(
        # theme_path="/home/developer/.config/qtile/icons/volume",
        limit_normal=80,
        limit_high=100,
        limit_loud=101,
    ),
    widget.Clock(
        format="%A %d %B %Y %H:%M",
        # mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')},
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
    widget.Bluetooth(),
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
            background=bar_background_color
            + format(int(bar_background_opacity * 255), "02x"),
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
