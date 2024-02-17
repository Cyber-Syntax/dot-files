from qtile_extras import widget
from libqtile import bar, extension, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
import os
import colors
colors = colors.Dracula

# Defaul widget settings
widget_defaults = dict(
    font="JetBrains Bold",
    fontsize=13,
    foreground=colors[7],
    background=colors[0],
    padding=5,
)

extension_defaults = widget_defaults.copy()

# Pin apps to the bar
pinned_apps = [
    ("", "flatpak run net.minetest.Minetest"),
    ("", "flatpak run org.telegram.desktop"),
    ("", "chromium"),
    ("", "flatpak run org.js.nuclear.Nuclear"),
    ("", "flatpak run com.tutanota.Tutanota"),
    ("", "nautilus"),
    ("", os.path.expanduser("~/Documents/appimages/siyuan.AppImage")),
    ("" , "flatpak run com.visualstudio.code"),
    ("", "flatpak run io.freetubeapp.FreeTube"),
    ("", "firefox"),
    ("", "gnome-terminal"),
]

# Textbox widget to start pinned apps
app_widgets = [
    widget.TextBox(
        text=" {} ".format(app_name),
        fontsize=16,
        foreground="#f8f8f2",
        background=colors[0],
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
                ## groups, e.g workspaces
                # widget.GroupBox(
                #          #visible_groups=visible_groups,
                #          fontsize = 11,
                #          margin_y = 5,
                #          margin_x = 5,
                #          padding_y = 0,
                #          padding_x = 1,
                #          borderwidth = 3,
                #          active = colors[8],
                #          inactive = colors[1],
                #          rounded = False,
                #          highlight_color = colors[2],
                #          highlight_method = "line",
                #          this_current_screen_border = colors[7],
                #          this_screen_border = colors [4],
                #          other_current_screen_border = colors[7],
                #          other_screen_border = colors[4],
                #          ),
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
                    selected = ('<b><span color="#8BE9FD">  ', '</span></b>'),
                ),
                widget.Spacer(length = 8),
                widget.CheckUpdates(
                    fmt = '{}',
                    distro = "Fedora",
                    update_interval = 60,
                    colour_have_updates = colors[6],
                    colour_no_updates = colors[7],
                    fontsize = 15,
                    display_format = ' {updates}',
                    no_update_string = '',
                    execute = 'gnome-terminal -- bash -c "~/.config/qtile/scripts/update-dnf-flatpak.sh"',
                    #custom_command = "os.path.expanduser('~/.config/qtile/scripts/dnf-update-status.py')",
                ),
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                ),
                widget.Volume(
                            # input device
                            channel = "Capture",
                            foreground = colors[1],
                            fmt = ' {}',
                            emoji = False,
                            check_mute_string = '[off]', # '' icon not working
                ),
                widget.Spacer(length = 8),
                widget.Volume(
                        foreground = colors[7],
                        fmt = '🕫 {}',
                        mouse_callbacks = {'Button3': lambda: qtile.spawn('gnome-terminal -- bash -c "~/.config/qtile/scripts/sink-change.sh --change"')},
                        ),
                widget.Spacer(length = 8),
                widget.Clock(
                        foreground = colors[8],
                        format = " %A %d/%m/%y %H:%M",
                        mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')},
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
                widget.CurrentLayout(
                        foreground = colors[1],
                        padding = 5
                        ),
            ],
            size=24  # Fix: Move the positional argument before the keyword argument
        )
    ),
    # HDMI-0: right monitor
    Screen(
        top=bar.Bar(
            widgets=[
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
                    separator = ' | ',
                    selected = ('<b><span color="#8BE9FD">  ', '</span></b>'),
                ),
                widget.Spacer(length = 8),
                widget.CPU(
                        format = ' {load_percent}%',
                        foreground = colors[4],

                        ),
                widget.Spacer(length = 8),
                widget.ThermalSensor(
                            foreground = colors[4],
                            fmt = ' {}',
                            update_interval = 2,
                            threshold = 60,
                            foreground_alert='ff6000',
                            ),
                widget.Spacer(length = 8),
                widget.NvidiaSensors(
                            foreground = 'ffffff',
                            fmt = ' {}',
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
                        fmt = '🖴 {}',
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
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                ),
                widget.Volume(
                            # input device
                            channel = "Capture",
                            foreground = colors[1],
                            fmt = ' {}',
                            emoji = False,
                            check_mute_string = '[off]', # '' icon not working
                ),
                widget.Spacer(length = 8),
                widget.Volume(
                        foreground = colors[7],
                        fmt = '🕫 {}',
                        mouse_callbacks = {'Button3': lambda: qtile.spawn('gnome-terminal -- bash -c "~/.config/qtile/scripts/sink-change.sh --change"')},
                        ),
                widget.Spacer(length = 8),
                widget.Clock(
                        foreground = colors[8],
                        format = " %A %d/%m/%y %H:%M",
                        mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')},
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
                widget.CurrentLayout(
                        foreground = colors[1],
                        padding = 5
                        ),
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                ),
                widget.Systray(padding = 3),
            ],
            size=20
        )
    ),
    # DP-0: left monitor
    Screen(
        top=bar.Bar(
            widgets=[
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
                    separator = ' | ',
                    selected = ('<b><span color="#8BE9FD">  ', '</span></b>'),
                ),
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                ),
                widget.Clock(
                        foreground = colors[8],
                        format = " %A %d/%m/%y %H:%M",
                        mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')},
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
                widget.CurrentLayout(
                        foreground = colors[1],
                        padding = 5
                        ),
            ],
            size=22
        )
    ),
]
