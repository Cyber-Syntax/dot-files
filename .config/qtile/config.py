import os
import subprocess
from libqtile import bar, extension, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from qtile_extras import widget
import colors

# Import the keybindings
from keys import keys, mouse

# Insert widget.py
from widget import init_widgets_list

# Log location
# ~/.local/share/qtile/qtile.log

# DP-0   left monitor    :   screen_affinity=2, group 1
# DP-2   primary monitor :   screen_affinity=0, group 2
# HDMI-0 right monitor   :   screen_affinity=1, group 3
groups = [
    Group("1", screen_affinity=2, layout="max"), # DP-0: left monitor
    Group("2", screen_affinity=0, layout="max"), # DP-2: primary monitor
    Group("3", screen_affinity=1, matches=[Match(wm_class="superproductivity")], layout="max"), # HDMI-0: right monitor
]

## Colors ##
colors = colors.Dracula

## Layouts ##
layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": colors[8],
                "border_normal": colors[0]
                }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Tile(
         shift_windows=True,
         border_width = 0,
         margin = 0,
         ratio = 0.335,
         ),
    layout.Max(
         border_width = 0,
         margin = 0,
         ),
]

## Widgets ##
widget_defaults = dict(
    font="Ubuntu Bold",
    fontsize = 12,
    padding = 0,
    background=colors[0]
)

extension_defaults = widget_defaults.copy()

## Widget definitions for per-screen widgets ##
    # Primary screen will display everything
    # systray can't be shown on all screens at the same time because qtiles doesn't support it
def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

# Secondary screen will display everything except the systray and spacer
def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    # Hide the systray and spacer
    del widgets_screen2[22]
    return widgets_screen2

# Tertiary screen will display everything except the systray and spacer
def init_widgets_screen3():
    widgets_screen3 = init_widgets_list()
    # Hide the systray and spacer
    del widgets_screen3[22]
    return widgets_screen3

# Function to update the screens
def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=30)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=26)),
            Screen(top=bar.Bar(widgets=init_widgets_screen3(), size=26))]

# Update the screens
if __name__ in ["config", "__main__"]:
    screens = init_screens()
    # @screen_num = 4 : I wanted to call else condition from "Visible groups per screen" section
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen3()

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
