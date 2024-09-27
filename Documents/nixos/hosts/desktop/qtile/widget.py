from libqtile import bar, extension, hook, layout, qtile
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
import os
import colors
import subprocess
### qtile extras
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
#from qtile_extras.widget.groupbox2 import GroupBoxRule
from qtile_extras.popup.templates.mpris2 import COMPACT_LAYOUT, DEFAULT_LAYOUT

colors = colors.Nord

# Defaul widget settings
widget_defaults = dict(
    font="JetBrains Mono Bold",
    fontsize=16,
    foreground=colors[1],
    background=colors[0],
    padding=1,
)

extension_defaults = widget_defaults.copy()

# qtile-extras definitions
decoration_group = {
        "decorations": [
            RectDecoration(colour="#181825", radius=10, filled=True, padding_y=4, group=True)
        ],
        "padding": 3,
}

# .qtile-extras

# # test show only when treshold is reached ram widget
# from qtile import widget
# from qtile.widget.base import _Widget
# import psutil
#
# class MemoryVisibility(_Widget):
#     defaults = [
#         ('update_interval', 1, 'Update interval in seconds.'),
#         ('threshold', 3, 'Memory usage percentage threshold for showing the widget.'),
#         ('fontsize', 14, 'Font size of the widget.'),
#         ('foreground_color', '#FFFFFF', 'Color of the text when visible.'),
#         ('hidden_foreground_color', '#000000', 'Color of the text when hidden.')
#     ]
#
#     def __init__(self, **config):
#         _Widget.__init__(self, **config)
#         self.add_defaults(MemoryVisibility.defaults)
#         self.threshold = self.threshold
#         self.visible = False  # Initial visibility state
#
#     def poll(self):
#         mem = psutil.virtual_memory()
#         percent = mem.percent
#         if percent > self.threshold:
#             if not self.visible:
#                 self.visible = True
#                 self.bar.draw()
#             return f'{percent:.0f}%'
#         else:
#             if self.visible:
#                 self.visible = False
#                 self.bar.draw()
#             return ''
#
#     def draw(self):
#         if self.visible:
#             self.foreground = self.foreground_color
#         else:
#             self.foreground = self.hidden_foreground_color
#         super().draw()




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
def set_label(rule, box):
    if box.focused:
        rule.text = "◉"
    elif box.occupied:
        rule.text = "◎"
    else:
        rule.text = "○"

    return True

## Screens ##
screens = [
    # Primary monitor
    Screen(
        top=bar.Bar(
             widgets=[
                 widget.Spacer(length = 8),

    #MemoryVisibility(
    #     update_interval=10,
    #     fontsize=14,
    #     threshold=3,
    #     foreground_color='#FF0000',  # Color when the widget is visible
    #     hidden_foreground_color='#000000',  # Color when the widget is hidden
    # ),

                #*app_widgets,
                widget.Spacer(length = 8),
                ## groups, e.g workspaces
                widget.GroupBox(
                        # # multi monitor setup
                        # # DP-2: 2,4,6,8
                        #  visible_groups=['2', '4', '6'],

                         fontsize = 15,
                         margin_y = 5,
                         margin_x = 5,
                         padding_y = 0,
                         padding_x = 1,
                         borderwidth = 3,
                         active = colors[3],
                         inactive = colors[2],
                         rounded = True,
                         highlight_color = colors[0],
                         highlight_method = "line",
                         this_current_screen_border = colors[7],
                         this_screen_border = colors [4],
                         other_current_screen_border = colors[7],
                         other_screen_border = colors[4],
                        **decoration_group,
                        #rules = [GroupBoxRule().when(func=set_label)]

                         ),
                # widget.TextBox(
                #         text = '|',
                #         font = "Ubuntu Mono",
                #         foreground = colors[1],
                #         padding = 2,
                #         fontsize = 14
                #         ),
                widget.Spacer(length = 8),
                widget.TaskList(
                    highlight_method = "block",
                    foreground = colors[1],
                    background = colors[0],
                    max_title_with = 80,
                    txt_minimized = '',
                    txt_floating = '',
                    txt_maximized = '',
                    # get only app names
                    #parse_text=lambda text: '|' + text,
                    spacing = 20,
                    icon_size = 20,
                    border_width = 0,
                    ),

                # widget.WindowName(
                #     **decoration_group,
                #     for_current_screen=True,
                #     ),
                # widget.WindowTabs(
                #     fmt = '{}',
                #     #max_chars = 50,
                #     foreground = colors[7],
                #     background = colors[0],
                #     separator = '  ',
                #     selected = ('<b><span color="#8BE9FD">  ', '</span></b>'),
                #     **decoration_group,
                # ),                
                widget.Spacer(length = 8),                
                widget.Mpris2(
                    fmt = '{}',
                    format = '{xesam:title} - {xesam:artist}',
                    foreground = colors[7],
                    paused_text = ' {track}',
                    playing_text = ' {track}',
                    scroll_fixed_width = False,
                    max_chars = 200,
                    separator = ', ',
                    stopped_text = '',
                    width=200,
                    **decoration_group,
                ),
                widget.Spacer(length = 8),
                widget.CPU(
                        format = ' {freq_current}GHz {load_percent}%',
                        foreground = colors[4],
                        **decoration_group,
                        ),
                widget.Spacer(length = 8),
                widget.ThermalSensor(
                            tag_sensor='Tctl',
                            foreground = colors[4],
                            fmt = ' {}',
                            update_interval = 2,
                            threshold = 60,
                            foreground_alert='ff6000',
                            **decoration_group,
                            ),
                widget.Spacer(length = 8),
                widget.NvidiaSensors(
                            foreground = 'ffffff',
                            fmt = ' {}',
                            format = '{temp}°C {fan_speed} {perf}',
                            update_interval = 2,
                            threshold = 60,
                            foreground_alert='ff6000',
                            **decoration_group,
                            ),
                widget.Spacer(length = 8),
                # widget.Memory(
                #         foreground = colors[8],
                #         measure_mem='G',
                #         #mouse_callbacks = {'Button1': lambda: qtile.spawn(terminal + ' -e htop')},
                #         format = '{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}',
                #         fmt = ' {}',
                #         **decoration_group,
                #         ),
                widget.Spacer(length = 8),
                widget.DF(
                    update_interval = 60,
                    foreground = colors[5],
                    partition = '/',
                    format = '{r:.0f}%',
                    fmt = ' {}',
                    visible_on_warn = False,
                    **decoration_group,
                    ),
                widget.Spacer(length = 8),
                widget.DF(
                    update_interval = 60,
                    foreground = colors[5],
                    partition = '/home',
                    format = '{r:.0f}%',
                    fmt = ' {}',
                    visible_on_warn = False,
                    **decoration_group,
                    ),

                widget.Spacer(length = 8),
                widget.DF(
                    update_interval = 60,
                    foreground = colors[5],
                    partition = '/nix',
                    format = '{r:.0f}%',
                    fmt = ' {}',
                    visible_on_warn = False,
                    **decoration_group,
                    ),
                widget.Spacer(length = 8),
                widget.DF(
                    update_interval = 60,
                    foreground = colors[5],
                    partition = '/mnt/backups',
                    format = '{r:.0f}%',
                    fmt = ' {}',
                    visible_on_warn = False,
                    **decoration_group,
                    ),         
                widget.Spacer(length = 8),
                # widget.TextBox(
                #         text = '|',
                #         font = "Ubuntu Mono",
                #         foreground = colors[1],
                #         padding = 2,
                #         fontsize = 14
                # ),

 #               widget.Spacer(length = 8),
                # # TODO: Debug
                # widget.CheckUpdates(
                #     fmt = '{}',
                #     distro = 'Arch',
                #     update_interval = 60,
                #     colour_have_updates = colors[6],
                #     colour_no_updates = colors[7],
                #     fontsize = 15,
                #     display_format = 'Arch:{updates}',
                #     no_update_string = '',
                # ),
                # widget.TextBox(
                #         text = '|',
                #         font = "Ubuntu Mono",
                #         foreground = colors[1],
                #         padding = 2,
                #         fontsize = 14
                # ),

# Work on nixos, not on arch
                widget.Volume(
                            foreground = colors[1],
                            fmt = '🔈{}',
                            emoji = False,
                            check_mute_string = '[off]', # '' icon not working
                    mouse_callbacks={
                        # Left click to change volume output
                        #'Button1': lambda: qtile.spawn('kitty -- bash -c "~/.config/qtile/scripts/sink-change.sh --change"'),
                        'Button1': lambda: qtile.spawn('kitty -- bash -c "~/Documents/nixos/hosts/desktop/qtile/scripts/sink-change.sh --change"'),
                        # Right click to open pavucontrol
                        'Button3': lambda: qtile.spawn('pavucontrol'),
                                     },
                    **decoration_group,
                ),
                # widget.Spacer(length = 8),

# # Custom volume widget
#                  widget.GenPollText(
#                     update_interval=1,
#    func=lambda: subprocess.check_output("~/.config/qtile/scripts/sink-change.sh --status", shell=True, text=True),
#                     # call script when clicked
#                     mouse_callbacks={'Button1': lambda: qtile.spawn('kitty -- bash -c "~/.config/qtile/scripts/sink-change.sh --change"')}
# ),

                # # # TODO: Not working on pipewire arch
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
                        **decoration_group,
                        #mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')}, 
                        ),
            widget.Spacer(length = 8),
            widget.Systray(                        
                        **decoration_group,
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
                # widget.TextBox(
                #         text = '|',
                #         font = "Ubuntu Mono",
                #         foreground = colors[1],
                #         padding = 2,
                #         fontsize = 14
                #         ),      
                # New custom widget to call my xrandr.sh script via mouse callback
                widget.TextBox(
                    text=" ",
                    fontsize=16,
                    foreground="#f8f8f2",
                    background=colors[0],
                    mouse_callbacks={'Button1': lazy.spawn(os.path.expanduser("/home/developer/Documents/screenloyout/xrandr.sh"))}                    
                ),
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
            size=30  # Fix: Move the positional argument before the keyword argument
        )
    ),


# #    # DP-0: left monitor
#     Screen(
#         top=bar.Bar(
#             widgets=[
#                 ## groups, e.g workspaces
#                 widget.GroupBox(
#                          #visible_groups=visible_groups,
#                         visible_groups=['1', '3', '5'],
#                          fontsize = 15,
#                          margin_y = 5,
#                          margin_x = 5,
#                          padding_y = 0,
#                          padding_x = 1,
#                          borderwidth = 3,
#                          active = colors[3],
#                          inactive = colors[2],
#                          rounded = True,
#                          highlight_color = colors[0],
#                          highlight_method = "line",
#                          this_current_screen_border = colors[7],
#                          this_screen_border = colors [4],
#                          other_current_screen_border = colors[7],
#                          other_screen_border = colors[4],
#                         **decoration_group,
#                          ),
#                 widget.Spacer(length = 8),
#                 widget.WindowTabs(
#                     fmt = '{}',
#                     foreground = colors[7],
#                     separator = ' | ',
#                     selected = ('<b><span color="#8BE9FD">   ', '</span></b>'),
#                     **decoration_group,
#                 ),
#                 widget.Spacer(length = 8),
#                 widget.Clock(
#                         foreground = colors[8],
#                         format = "  %A %d/%m/%y %H:%M",
#                         mouse_callbacks = {'Button1': lambda: qtile.spawn('gnome-calendar')},
#                         **decoration_group,
#                         ),
#                 widget.Spacer(length = 8),
#                 widget.CurrentLayoutIcon(
#                         foreground = colors[1],
#                         padding = 4,
#                         scale = 0.6
#                         ),
#             ],
#             size=29
#         )
#     ),
# #    ./end-DP-0


]

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

