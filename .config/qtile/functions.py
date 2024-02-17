from libqtile.lazy import lazy

## Custom Functions ##
# My functions only work with 3 groups and 3 screens and layout is max.
# @send_left = Send the current window to the left screen
# @send_right = Send the current window to the right screen
# @focus_left = Focus the left screen
# @focus_right = Focus the right screen

@lazy.function
def send_left(qtile):
    """Send the current window to the left screen. Only works with 3 groups and 3 screens."""
    # Find screen_affinity use that index to send to the right monitor
    screen_affinity = qtile.current_screen.group.screen_affinity

    if screen_affinity == 2:
        qtile.current_window.togroup(qtile.screens[1].group.name, switch_group=False)
        qtile.focus_screen(1)
    elif screen_affinity == 0:
        qtile.current_window.togroup(qtile.screens[2].group.name, switch_group=False)
        qtile.focus_screen(2)
    else:
        qtile.current_window.togroup(qtile.screens[0].group.name, switch_group=False)
        qtile.focus_screen(0)

@lazy.function
def send_right(qtile):
    """Send the current window to the right screen. Only works with 3 groups and 3 screens."""
    # Find screen_affinity use that index to send to the right monitor
    screen_affinity = qtile.current_screen.group.screen_affinity

    if screen_affinity == 2:
        qtile.current_window.togroup(qtile.screens[0].group.name, switch_group=False)
        # Focus can't stay on window when sending from DP-0 to DP-2 when layout isn't max.
        qtile.focus_screen(0)
    elif screen_affinity == 0:
        qtile.current_window.togroup(qtile.screens[1].group.name, switch_group=False)
        qtile.focus_screen(1)
    else:
        qtile.current_window.togroup(qtile.screens[0].group.name, switch_group=False)
        qtile.focus_screen(0)

@lazy.function
def focus_left(qtile):
    """Focus the left screen. Only works with 3 groups and 3 screens."""
    if len(qtile.screens) == 1:
        qtile.focus_screen(qtile.current_screen.previous_group)
        return

    if qtile.current_screen.index == 0:
        qtile.focus_screen(2)
    elif qtile.current_screen.index == 1:
        qtile.focus_screen(0)
    else:
        qtile.focus_screen(qtile.current_screen.previous_group)

@lazy.function
def focus_right(qtile):
    """Focus the right screen. Only works with 3 groups and 3 screens."""
    if len(qtile.screens) == 1:
        qtile.focus_screen(qtile.current_screen.next_group)
        return

    if qtile.current_screen.index == 2:
        qtile.focus_screen(0)
    elif qtile.current_screen.index == 0:
        qtile.focus_screen(1)
    else:
        qtile.focus_screen(qtile.current_screen.next_group)

# # Add groups to keybindings, e.g to switch to group 1 use mod+1
# def go_to_group(name: str):
#     def _inner(qtile):
#         if len(qtile.screens) == 1:
#             qtile.groups_map[name].toscreen()
#             return

#         if name in '1':
#             qtile.focus_screen(2) # DP-0
#             qtile.groups_map[name].toscreen()
#         elif name in '2':
#             qtile.focus_screen(0) # DP-2
#             qtile.groups_map[name].toscreen()
#         else:
#             qtile.focus_screen(1) # HDMI-0
#             qtile.groups_map[name].toscreen()

#     return _inner

# # Add keybindings for changing groups
# for i in groups:
#     keys.append(Key([mod], i.name, lazy.function(go_to_group(i.name))))

# # Add keybindings for moving windows to groups, e.g. to move window to group 1 use mod+shift+1
# def go_to_group_and_move_window(name: str):
#     def _inner(qtile):
#         if len(qtile.screens) == 1:
#             qtile.current_window.togroup(name, switch_group=True)
#             return

#         if name in '1':
#             qtile.current_window.togroup(name, switch_group=False)
#             qtile.focus_screen(2) # DP-0
#             qtile.groups_map[name].toscreen()
#         elif name in '2':
#             qtile.current_window.togroup(name, switch_group=False)
#             qtile.focus_screen(0) # DP-2
#             qtile.groups_map[name].toscreen()
#         else:
#             qtile.current_window.togroup(name, switch_group=False)
#             qtile.focus_screen(1) # HDMI-0
#             qtile.groups_map[name].toscreen()

#     return _inner

# # Add keybindings for moving windows to groups
# for i in groups:
#     keys.append(Key([mod, "shift"], i.name, lazy.function(go_to_group_and_move_window(i.name))))
