#from qtile_extras import widget
from libqtile import bar, extension, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
import os
import colors
import subprocess
colors = colors.TomorrowNight 

# Defaul widget settings
widget_defaults = dict(
    font="JetBrains Mono Bold",
    fontsize=13,
    foreground=colors[7],
    background=colors[0],
    padding=1,
)

extension_defaults = widget_defaults.copy()

# Pin apps to the bar
pinned_apps = [
    #("", "flatpak run net.minetest.Minetest"),
    #("", os.path.expanduser("~/Documents/appimages/appman_apps/telegram/Telegram")),
    #("", os.path.expanduser("~/Documents/appimages/appman_apps/ungoogled-chromium/ungoogled-chromium")),
    #("", os.path.expanduser("~/Documents/appimages/appman_apps/nuclear/nuclear")),
    #("", os.path.expanduser("~/Documents/appimages/appman_apps/tutanota/tutanota")),
    #("", "pcmanfm"),
    #("", os.path.expanduser("~/Documents/appimages/siyuan.AppImage")),
    #("", os.path.expanduser("~/Documents/appimages/appman_apps/freetube/freetube")),
    #("", os.path.expanduser("~/Documents/appimages/appman_apps/syncthing-tray/syncthing-tray")),
    #("", "firefox"),
    #("", os.path.expanduser("~/Documents/appimages/appman_apps/brave/brave")),
    #("", "kitty"),
    #("", os.path.expanduser("~/Documents/appimages/appman_apps/flameshot/flameshot")),
    #("", os.path.expanduser("~/Documents/appimages/appman_apps/keepassxc/keepassxc")),
    ("", "keepassxc"),
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
                #*app_widgets,
                widget.Spacer(length = 8),
                ## groups, e.g workspaces
                widget.GroupBox(
                         # DP-2: 2,4,6,8
                         #visible_groups=['2', '4', '6', '8'],
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
                    # Not work on arch for now, developers didn't add some modules to main arch repo yet.
                # widget.PulseVolume(
                #     foreground = colors[1],
                #     fmt = ' {}',
                #     mouse_callbacks = {'Button3': lambda: qtile.spawn('pavucontrol')},
                #     ),
                widget.Spacer(length = 8),
                widget.CPU(
                        format = ' {load_percent}%',
                        foreground = colors[4],
                        ),
                widget.Spacer(length = 8),
                widget.ThermalSensor(
                            tag_sensor='Tctl',
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
                        format = '{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}',
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
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                ),
                widget.Spacer(length = 8),
                # TODO: Debug
                widget.CheckUpdates(
                    fmt = '{}',
                    distro = 'Arch',
                    update_interval = 60,
                    colour_have_updates = colors[6],
                    colour_no_updates = colors[7],
                    fontsize = 15,
                    display_format = 'Arch:{updates}',
                    no_update_string = '',
                ),
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                ),
                # widget.Volume(
                #             # input device
                #             #channel = "Capture",
                #             foreground = colors[1],
                #             fmt = ' {}',
                #             emoji = False,
                #             check_mute_string = '[off]', # '' icon not working
                # ),
                # widget.Spacer(length = 8),

# Custom volume widget
                 widget.GenPollText(
                    update_interval=1,
   func=lambda: subprocess.check_output("~/.config/qtile/scripts/sink-change.sh --status", shell=True, text=True),
                    # call script when clicked
                    mouse_callbacks={'Button1': lambda: qtile.spawn('kitty -- bash -c "~/.config/qtile/scripts/sink-change.sh --change"')}
),

                # # TODO: Not working on pipewire arch
                # widget.Volume(
                #         foreground = colors[7],
                #         cardid = 0,
                #         channel = "Master",
                #         get_volume_command = "os.path.expanduser('~/.config/qtile/scripts/sink-change.sh --status')",
                #         #get_volume_command = "",
                #         device = "default",
                #         fmt = ' {}',
                #         #emoji = False,
                #         update_interval = 0.2,
                #         volume_app = "pavucontrol",
                #         mouse_callbacks = {'Button3': lambda: qtile.spawn('kitty -- bash -c "~/.config/qtile/scripts/sink-change.sh --change"')},
                #         ),
                
                widget.Spacer(length = 8),
                widget.Clock(
                        foreground = colors[8],
                        format = "  %A %d/%m/%y %H:%M",
                        #mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')}, 
                        ),
                widget.TextBox(
                        text = '|',
                        font = "Ubuntu Mono",
                        foreground = colors[1],
                        padding = 2,
                        fontsize = 14
                        ),
              widget.Systray(padding = 3),
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
                # # New custom widget to call my xrandr.sh script via mouse callback
                # widget.TextBox(
                #     text=" ",
                #     fontsize=16,
                #     foreground="#f8f8f2",
                #     background=colors[0],
                #     mouse_callbacks={'Button1': lazy.spawn(os.path.expanduser("~/Documents/screenloyout/xrandr.sh"))}                    
                # ),
                # widget.Spacer(length = 8),
                # # New custom widget to call my xrandr-movie.sh script via mouse callback
                # widget.TextBox(
                #     text=" ",
                #     fontsize=16,
                #     foreground="#f8f8f2",
                #     background=colors[0],
                #     mouse_callbacks={'Button1': lazy.spawn(os.path.expanduser("~/Documents/screenloyout/xrandr-movie.sh"))}                    
                # ),
            ],
            size=24  # Fix: Move the positional argument before the keyword argument
        )
    ),
    # no longer used monitor
    # # HDMI-0: right monitor
    # Screen(
    #     top=bar.Bar(
    #         widgets=[
    #             widget.TextBox(
    #                     text = '|',
    #                     font = "Ubuntu Mono",
    #                     foreground = colors[1],
    #                     padding = 2,
    #                     fontsize = 14
    #                     ),
    #             widget.WindowTabs(
    #                 fmt = '{}',
    #                 foreground = colors[7],
    #                 separator = ' | ',
    #                 selected = ('<b><span color="#8BE9FD">    ', '</span></b>'),
    #             ),
    #             widget.Spacer(length = 8),
    #             widget.CPU(
    #                     format = ' {load_percent}%',
    #                     foreground = colors[4],
    #                     ),
    #             widget.Spacer(length = 8),
    #             widget.ThermalSensor(
    #                         tag_sensor='Tctl',
    #                         foreground = colors[4],
    #                         fmt = ' {}',
    #                         update_interval = 2,
    #                         threshold = 60,
    #                         foreground_alert='ff6000',
    #                         ),
    #             widget.Spacer(length = 8),
    #             widget.NvidiaSensors(
    #                         foreground = 'ffffff',
    #                         fmt = ' {}',
    #                         update_interval = 2,
    #                         threshold = 60,
    #                         foreground_alert='ff6000',
    #                         ),
    #             widget.Spacer(length = 8),
    #             widget.Memory(
    #                     foreground = colors[8],
    #                     measure_mem='G',
    #                     #mouse_callbacks = {'Button1': lambda: qtile.spawn(terminal + ' -e htop')},
    #                     format = '{MemPercent}% - {MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}',
    #                     fmt = ' {}',
    #                     ),
    #             widget.Spacer(length = 8),
    #             widget.DF(
    #                     update_interval = 60,
    #                     foreground = colors[5],
    #                     partition = '/',
    #                     format = '{r:.0f}%',
    #                     fmt = ' {}',
    #                     visible_on_warn = False,
    #                     ),
    #             widget.Spacer(length = 8),
    #             widget.DF(
    #                 update_interval = 60,
    #                 foreground = colors[5],
    #                 partition = '/home',
    #                 format = '{r:.0f}%',
    #                 fmt = ' {}',
    #                 visible_on_warn = False,
    #                 ),
    #             widget.TextBox(
    #                     text = '|',
    #                     font = "Ubuntu Mono",
    #                     foreground = colors[1],
    #                     padding = 2,
    #                     fontsize = 14
    #             ),
    #                             widget.Spacer(length = 8),
    #             widget.Clock(
    #                     foreground = colors[8],
    #                     format = "  %A %d/%m/%y %H:%M",
    #                     mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')},
    #                     ),
    #             widget.TextBox(
    #                     text = '|',
    #                     font = "Ubuntu Mono",
    #                     foreground = colors[1],
    #                     padding = 2,
    #                     fontsize = 14
    #                     ),
    #             widget.CurrentLayoutIcon(
    #                     foreground = colors[1],
    #                     padding = 4,
    #                     scale = 0.6
    #                     ),
    #             widget.CurrentLayout(
    #                     foreground = colors[1],
    #                     padding = 5
    #                     ),
    #             widget.TextBox(
    #                     text = '|',
    #                     font = "Ubuntu Mono",
    #                     foreground = colors[1],
    #                     padding = 2,
    #                     fontsize = 14
    #             ),
    #         ],
    #         size=20
    #     )
    # ),
 #    # DP-0: left monitor
 #    Screen(
 #        top=bar.Bar(
 #            widgets=[
 #                ## groups, e.g workspaces
 #                widget.GroupBox(
 #                         #visible_groups=visible_groups,
 #                        visible_groups=['1', '3', '5', '7', '9'],
 #                         fontsize = 11,
 #                         margin_y = 5,
 #                         margin_x = 5,
 #                         padding_y = 0,
 #                         padding_x = 1,
 #                         borderwidth = 3,
 #                         active = colors[8],
 #                         inactive = colors[1],
 #                         rounded = False,
 #                         highlight_color = colors[2],
 #                         highlight_method = "line",
 #                         this_current_screen_border = colors[7],
 #                         this_screen_border = colors [4],
 #                         other_current_screen_border = colors[7],
 #                         other_screen_border = colors[4],
 #                         ),
 # 
 #                widget.TextBox(
 #                        text = '|',
 #                        font = "Ubuntu Mono",
 #                        foreground = colors[1],
 #                        padding = 2,
 #                        fontsize = 14
 #                        ),
 #                widget.WindowTabs(
 #                    fmt = '{}',
 #                    foreground = colors[7],
 #                    separator = ' | ',
 #                    selected = ('<b><span color="#8BE9FD">   ', '</span></b>'),
 #                ),
 #
 #                widget.TextBox(
 #                        text = '|',
 #                        font = "Ubuntu Mono",
 #                        foreground = colors[1],
 #                        padding = 2,
 #                        fontsize = 14
 #                ),
 #                widget.Clock(
 #                        foreground = colors[8],
 #                        format = "  %A %d/%m/%y %H:%M",
 #                        mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')},
 #                        ),
 #                widget.TextBox(
 #                        text = '|',
 #                        font = "Ubuntu Mono",
 #                        foreground = colors[1],
 #                        padding = 2,
 #                        fontsize = 14
 #                        ),
 #                widget.CurrentLayoutIcon(
 #                        foreground = colors[1],
 #                        padding = 4,
 #                        scale = 0.6
 #                        ),
 #                widget.CurrentLayout(
 #                        foreground = colors[1],
 #                        padding = 5
 #                        ),
 #            ],
 #            size=22
 #        )
 #    ),
    #./end-DP-0
]
