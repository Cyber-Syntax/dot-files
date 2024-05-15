# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
from libqtile import bar, extension, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
# Import widget from qtile_extras instead of libqtile
#from qtile_extras import widget
# Import colors
import colors
# Import the keybindings
from keys import *
# Import widget.py
from widget import *

# Log location
# ~/.local/share/qtile/qtile.log

# @param: screen_affinity: monitor to display the group on
# @param: group: the group to display on the monitor
# DP-0   left monitor    :   screen_affinity=2, group 1
# DP-2   primary monitor :   screen_affinity=0, group 2
#### HDMI-0 right monitor   :   screen_affinity=1, group 3 ## Undetached
groups = [
    ## 1 monitor setup
    Group("1", screen_affinity=0, layout="max", matches=[Match(wm_class=['firefox-browser', 'brave-browser', 'chromium-browser'])],  label=""),
    Group("2", screen_affinity=0, layout="max", label=""),
    Group("3", screen_affinity=0, layout="max", matches=[Match(wm_class=['siyuan', 'SiYuan'])], label=""),
    Group("4", screen_affinity=0, layout="max", matches=[Match(wm_class="superproductivity")], label="", init=True),
    Group("5", screen_affinity=0, layout="max", label="", matches=[Match(wm_class=['pcmanfm', 'libreoffice', 'calibre'])]),
    Group("6", screen_affinity=0, layout="max", label="", matches=[Match(wm_class="nuclear")]),
    ## 2 monitor setup
    # Group("1", screen_affinity=2, matches=[Match(wm_class="superproductivity")], layout="max", init=True), # DP-0: left monitor
    # Group("2", screen_affinity=0, layout="max", init=True), # DP-2: primary monitor
    # Group("3", screen_affinity=2, layout="max"), # DP-0: left monitor
    # Group("4", screen_affinity=0, layout="max"),
    # Group("5", screen_affinity=2, layout="max"),
    # Group("6", screen_affinity=0, layout="max"),
    # Group("7", screen_affinity=2, layout="max"),
    # Group("8", screen_affinity=0, layout="max"),
    # Group("9", screen_affinity=2, layout="max"),
]
# Add groups to keybindings, e.g to switch to group 1 use mod+1
#TODO: Fix, sending other workspace not work as expected
# Cause: when sending window from dp-0 to dp-2,mod+shift+4 -> it can't send correctly because we didn't handle the screen_affinity
for i in groups:
    keys.append(Key([mod], i.name, lazy.group[i.name].toscreen()) )
    keys.append(Key([mod, "shift"], i.name, lazy.window.togroup(i.name))),

## Layouts ##
layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": colors[8],
                "border_normal": colors[0]
                }

layouts = [
    layout.MonadTall(**layout_theme),
#     layout.Tile(
#          shift_windows=True,
#          border_width = 0,
#          margin = 0,
#          ratio = 0.335,
#          ),
     layout.Max(
         border_width = 0,
         margin = 0,
         ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
bring_front_click = False

# Take mouse focus with window while focusing or moving windows
cursor_warp = True
follow_mouse_focus = True

## Rules ##
floating_layout = layout.Floating(
    border_focus=colors[8],
    border_width=2,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        # keepassxc
        Match(wm_class='keepassxc'),
        Match(wm_class="confirmreset"),   # gitk
        Match(wm_class="dialog"),         # dialog boxes
        Match(wm_class="download"),       # downloads
        Match(wm_class="error"),          # error msgs
        Match(wm_class="file_progress"),  # file progress boxes
        Match(wm_class='kdenlive'),       # kdenlive
        Match(wm_class="makebranch"),     # gitk
        Match(wm_class="maketag"),        # gitk
        Match(wm_class="notification"),   # notifications
        Match(wm_class='pinentry-gtk-2'), # GPG key password entry
        Match(wm_class="ssh-askpass"),    # ssh-askpass
        Match(wm_class="toolbar"),        # toolbars
        Match(wm_class="Yad"),            # yad boxes
        Match(title="branchdialog"),      # gitk
        Match(title='Confirmation'),      # tastyworks exit box
        Match(title='Qalculate!'),        # qalculate-gtk
        Match(title="pinentry"),          # GPG key password entry
        Match(title="tastycharts"),       # tastytrade pop-out charts
        Match(title="tastytrade"),        # tastytrade pop-out side gutter
        Match(title="tastytrade - Portfolio Report"), # tastytrade pop-out allocation
        Match(wm_class="tasty.javafx.launcher.LauncherFxApp"), # tastytrade settings
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
