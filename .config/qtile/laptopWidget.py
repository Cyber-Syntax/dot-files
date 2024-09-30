#from qtile_extras import widget
from libqtile import bar, extension, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
import os
import colors
import subprocess
from qtile_extras import widget as extrawidgets
from qtile_extras.widget.decorations import RectDecoration

colors = colors.Nord

#RectDecoration
decoration_group = {
    "decorations": [
        RectDecoration(colour=colors[7], radius=10, filled=True, padding_y=4, group=True)
    ],
    "padding": 10,
}

# Defaul widget settings
widget_defaults = dict(
    font="JetBrains Mono Bold",
    fontsize=14,
    foreground=colors[7],
    background=colors[2],
    padding=1,
)

extension_defaults = widget_defaults.copy()

# # Pin apps to the bar
# pinned_apps = [
#     ("", os.path.expanduser("~/Documents/appimages/appman_apps/syncthing-tray/syncthing-tray")),
#     ("", os.path.expanduser("~/Documents/appimages/appman_apps/flameshot/flameshot")),
# ]

# Textbox widget to start pinned apps
app_widgets = [
    widget.TextBox(
        text=" {} ".format(app_name),
        fontsize=16,
        foreground="#f8f8f2",
        background=colors[2],
        mouse_callbacks={'Button1': lazy.spawn(app_cmd)}
    )
    for app_name, app_cmd in pinned_apps
]

## Screens ##
screens = [
    # Primary monitor
    Screen(
        top=bar.Bar(
            widgets=[
                widget.Spacer(length = 8),
                *app_widgets,
                widget.Spacer(length = 8),
                #widget.GroupBox(**decoration_group),
               # groups, e.g workspaces
                widget.GroupBox(
                         #visible_groups=visible_groups,
                         fontsize = 11,
                         margin_y = 5,
                         margin_x = 5,
                         padding_y = 0,
                         padding_x = 1,
                         borderwidth = 3,
                         active = colors[8],
                         inactive = colors[1],
                         rounded = False,
                         highlight_color = colors[2],
                         highlight_method = "line",
                         this_current_screen_border = colors[7],
                         this_screen_border = colors [4],
                         other_current_screen_border = colors[7],
                         other_screen_border = colors[4],
                            **decoration_group,
                         ),
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                        ),
                widget.WindowTabs(
                    fmt = '{}',
                    foreground = colors[7],
                    background = colors[0],
                    separator = ' | ',
                    selected = ('<b><span color="#8BE9FD">   ', '</span></b>'),
                ),
                # widget.Mpris2(
                # fmt = '{}',
                # format = '{xesam:title} - {xesam:artist}',
                # foreground = colors[7],
                # paused_text = ' {track}',
                # playing_text = ' {track}',
                # scroll_fixed_width = False,
                # max_chars = 200,
                # separator = ', ',
                # stopped_text = '',
                # width=200,
                # ),
                widget.Spacer(length = 8),
                widget.CPU(
                   fmt = '  {}',
                    format = '{freq_current}GHz {load_percent}%',
                ),
                widget.Spacer(length = 8),
                widget.ThermalZone(
                            foreground = colors[4],
                            fmt = ' {}',
                            update_interval = 2,
                            threshold = 60,
                            foreground_alert='ff6000',
                            ),
                widget.Spacer(length = 8),
                widget.Memory(
                        foreground = colors[8],
                        measure_mem='G',
                        #mouse_callbacks = {'Button1': lambda: qtile.spawn(terminal + ' -e htop')},
                        format = '{MemPercent}% - {MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}',
                        fmt = ' {}',
                         ),
                widget.Spacer(length = 8),
                widget.DF(
                        update_interval = 60,
                        foreground = colors[5],
                        partition = '/',
                        format = '{r:.0f}%',
                        fmt = ' {}',
                        visible_on_warn = False,
                        ),
                widget.Spacer(length = 8),
                widget.DF(
                    update_interval = 60,
                    foreground = colors[5],
                    partition = '/home',
                    format = '{r:.0f}%',
                    fmt = ' {}',
                    visible_on_warn = False,
                ),
                widget.Spacer(length = 8),
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                        ),
                widget.Battery (
                    background = colors[10],
                ),
                
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                        ),

                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                ),

# # Custom volume widget
#                  widget.GenPollText(
# update_interval=1,
# func=lambda: subprocess.check_output("~/.config/qtile/scripts/sink-change.sh --status", shell=True, text=True),
# # call script when clicked
# mouse_callbacks={'Button1': lambda: qtile.spawn('kitty -- bash -c "~/.config/qtile/scripts/sink-change.sh --change"')}
# ),
                extrawidgets.Volume(),
                widget.Spacer(length = 8),
                widget.Clock(
                        foreground = colors[8],
                        format = "  %A %d/%m/%y %H:%M",
                        #mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')}, 
                        ),
                widget.Spacer(length = 8),
             widget.Systray(
                    padding = 3,
                    background = colors[9],

                            ),
            widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                        ),
                widget.CurrentLayoutIcon(
                        foreground = colors[1],
                        padding = 4,
                        scale = 0.6
                        ),
                # widget.CurrentLayout(
                #         foreground = colors[1],
                #         padding = 5
                #         ),
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                        ),
                #qtile_extras.widget.Bluetooth
                widget.Bluetooth(
                    default_show_battery = True,
                    symbol_connected = '',
                    symbol_powered = ('*', '-'),
                    symbol_discovery = ('D', ''),
                    symbol_paired = '-',
                ),
            ],
            size=24  # Fix: Move the positional argument before the keyword argument
        )
    ),
]
