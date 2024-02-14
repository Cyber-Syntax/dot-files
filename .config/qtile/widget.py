from qtile_extras import widget
from libqtile import bar, extension, hook, layout, qtile, widget
import colors

colors = colors.Dracula

## Bar ##
def init_widgets_list():
    """Create the widgets list for the bar"""

    # # Visible groups per screen
    # if screen_num == 1:
    #     visible_groups = ["2"]
    # elif screen_num == 2:
    #     visible_groups = ["3"]
    # elif screen_num == 3:
    #     visible_groups = ["1"]
    # else:
    #     visible_groups = ["1", "2", "3"]

    widgets_list = [
        widget.Prompt(
                 font = "Ubuntu Mono",
                 fontsize=14,
                 foreground = colors[1]
        ),
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
        widget.WindowTabs(
            fmt = '{}',
            foreground = colors[7],
            separator = ' | ',
            selected = ('<b><span color="#8BE9FD">  ', '</span></b>'),
        ),
        widget.Spacer(length = 8),
        widget.Mpris2(
            fmt = '{}',
            format = '{xesam:title} - {xesam:artist}',
            foreground = colors[7],
            paused_text = ' {track}',
            playing_text = ' {track}',
            scroll_fixed_width = False,
            max_chars = 40,
            separator = ', ',
            stopped_text = '',
            width=200,
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
        widget.Spacer(length = 8),
        widget.Systray(padding = 3),
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

        widget.Spacer(length = 8),
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
                 format = " %d/%m/%y %H:%M",
                 ),
        widget.Spacer(length = 8),

        ]
    return widgets_list

# # Visible groups per screen
# # Defining the widget list for the screens
# screens = [
#     Screen(
#         top=bar.Bar(
#             init_widgets_list(1), 24
#         ),
#     ),
#     Screen(
#         top=bar.Bar(
#             init_widgets_list(2), 24
#         ),
#     ),
#     Screen(
#         top=bar.Bar(
#             init_widgets_list(3), 24
#         ),
#     ),
# ]

# ## Visible groups per screen ##
# groupbox1 = widget.GroupBox(visible_groups=["1"])
# groupbox2 = widget.GroupBox(visible_groups=["2"])
# groupbox3 = widget.GroupBox(visible_groups=["3"])

# # Update visible groups per screen when screens are reconfigured, e.g. when a screen is disconnected
# @hook.subscribe.screens_reconfigured
# async def _():
#     if len(qtile.screens) == 1:
#         groupbox1.visible_groups = ["1", "2", "3"]
#         groupbox2.visible_groups = ["1", "2", "3"]
#         groupbox3.visible_groups = ["1", "2", "3"]
#     else:
#         groupbox1.visible_groups = ["1"]
#         groupbox2.visible_groups = ["2"]
#         groupbox3.visible_groups = ["3"]
