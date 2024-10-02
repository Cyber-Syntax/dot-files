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
#TESTING: clear imports
from libqtile import hook, layout
from libqtile.config import Group, Key, Match

from libqtile.lazy import lazy
import re # this fixes the Match error on group

import colors
from functions import *

# 2 machine setup
def get_hostname():
    hostname = subprocess.check_output(['hostname']).decode('utf-8').strip()
    return hostname

hostname = get_hostname()

if hostname == "nixos":
    from widget import *
    from keys import *
elif hostname == "nixosLaptop":
    from laptopWidget import *
    from laptopKeys import *
else:
    print("No hostname found")

# Log location
# ~/.local/share/qtile/qtile.log
# `qtile cmd-obj -o cmd -f get_screens ` # find the screen index
# @param: screen_affinity: monitor to display the group on
# DP-2   left monitor    :   screen_affinity=0, group 2 # primary asus
# DP_4   right monitor :   screen_affinity=1, group 4 # view right

groups = [
    Group("1", screen_affinity=0, layout="monadtall", 
          matches=[Match(wm_class=re.compile(r"^(firefox-browser|brave-browser|chromium-browser)$"))], label=""),
    Group("2", screen_affinity=0, layout="monadtall", label=""),
    Group("3", screen_affinity=0, layout="monadtall", 
          matches=[Match(wm_class=re.compile(r"^(siyuan|obsidian)$"))], label=""),
    Group("4", screen_affinity=0, layout="max", 
          matches=[Match(wm_class=re.compile(r"^superproductivity$"))], label=""),
    Group("5", screen_affinity=0, layout="max", 
          matches=[Match(wm_class=re.compile(r"^(spotify|Spotify)$"))], label=""),
    Group("6", screen_affinity=0, layout="monadtall", label=""),
]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        # switch to group with ability to go to prevous group if pressed again
        #Key([mod], i.name, lazy.function(toscreen, i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": colors[8],
                "border_normal": colors[0]
                }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(
         border_width = 0,
         margin = 0,
    ),
]

floating_layout = layout.Floating(
    border_focus=colors[8],
    border_width=2,
    
    # auto_float_types=[
    #   "notification",
    #   "toolbar",
    #   "splash",
    #   "dialog",
    # ],

    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
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
#focus: urgent, smart, focus, or None
#focus ->  it's not work for break notifications on superproductivity but work for task notifications
focus_on_window_activation = "focus"
reconfigure_screens = True
bring_front_click = False
dgroups_key_binder = None
dgroups_app_rules = []  # type: list
bring_front_click = False

# Take mouse focus with window while focusing or moving windows
cursor_warp = True
follow_mouse_focus = True
# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

@hook.subscribe.startup_once
def start_once():
    # home = os.path.expanduser('~')
    # subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])
    #home = os.path.expanduser('~/Documents/nixos/home-manager/qtile_nixos/scripts/autostart.sh')

    home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
    subprocess.Popen([home])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
##"""
#"""
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
