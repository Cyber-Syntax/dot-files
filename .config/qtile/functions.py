from libqtile.lazy import lazy

# Import the keybindings
from keys import *


## Custom Functions ##
# My functions only work with 3 groups and 3 screens and layout is max.
# @send_left = Send the current window to the left screen
# @send_right = Send the current window to the right screen
# @focus_left = Focus the left screen
# @focus_right = Focus the right screen 
# DP-0   left monitor    :   screen_affinity=2, group 1
# DP-2   primary monitor :   screen_affinity=0, group 2
#### HDMI-0 right monitor   :   screen_affinity=1, group 3 ## Undetached

# TODO: lets make it for 2 screens and 2 groups because hdmi-0 is no longer in use.

# assing screen_affinity to each screen like DP-0 = 2, DP-2 = 0
DP_0 = 2
DP_2 = 0

# Cycle through the groups 
@lazy.function
def cycle_groups(qtile):
    """Cycle through the groups based on their workspace names"""
    # @param: current_group_index: The index of the current group
    # @param: next_group_index: The index of the next group
    current_group_index = qtile.groups.index(qtile.current_group)
    next_group_index = current_group_index
    
    # Check if the current group name is odd or even
    current_group_name = qtile.current_group.name
    is_odd_group = int(current_group_name) % 2 != 0

    # Loop through the groups until we find the desired group
    while True:
        # Get the next group name
        next_group_index = (next_group_index + 1) % len(qtile.groups)
        next_group_name = qtile.groups[next_group_index].name

        # Check if the next group name has the desired property (odd or even)
        if is_odd_group and int(next_group_name) % 2 != 0:
            break
        
        if not is_odd_group and int(next_group_name) % 2 == 0:
            break
    # Lets get back to the first group when we reach the last group
    # if 7 -> 1, 8 -> 2
    #TODO: Fix the issue with the last group
            # 8 can't go to 2 when 8 group available
            # 9 can't go to 1 when 9 group available
            # Workaround: setup 9 groups and use 1-8 groups and cycle 1 to 7(odds), 2 to 8(evens)
        if next_group_index == 8:
            # -1 = refers to the group 1, 0 refers to the group 2
            next_group_index = 0
        elif next_group_index == 7:
            next_group_index = -1


    qtile.current_screen.set_group(qtile.groups[next_group_index])

@lazy.function
def send_left(qtile):
    """Send the current window to the left screen."""
    # Find screen_affinity use that index to send to the right monitor
    screen_affinity = qtile.current_screen.group.screen_affinity

    if screen_affinity == DP_2:
        qtile.current_window.togroup(qtile.screens[1].group.name, switch_group=False)
        qtile.focus_screen(1) 
 

 # if screen_affinity == 2: # DP-2
    #     qtile.current_window.togroup(qtile.screens[1].group.name, switch_group=False)
    #     qtile.focus_screen(1)
    # elif screen_affinity == 0: # DP-0
    #     qtile.current_window.togroup(qtile.screens[2].group.name, switch_group=False)
    #     qtile.focus_screen(2)
    # else:                       # HDMI-0
    #     qtile.current_window.togroup(qtile.screens[0].group.name, switch_group=False)
    #     qtile.focus_screen(0)
    #
@lazy.function
def send_right(qtile):
    """Send right primary monitor"""
    screen_affinity = qtile.current_screen.group.screen_affinity


    if screen_affinity == DP_0:
        qtile.current_window.togroup(qtile.screens[0].group.name, switch_group=False)
        qtile.focus_screen(0)

    ### 3 monitor setup
    # if screen_affinity == 2: # DP-0
    #     qtile.current_window.togroup(qtile.screens[0].group.name, switch_group=False)
    #     # Focus can't stay on window when sending from DP-0 to DP-2 when layout isn't max.
    #     qtile.focus_screen(0)
    # elif screen_affinity == 0: # DP-2
    #     qtile.current_window.togroup(qtile.screens[1].group.name, switch_group=False)
    #     qtile.focus_screen(1)
    # else:                       # HDMI-0
    #     qtile.current_window.togroup(qtile.screens[0].group.name, switch_group=False)
    #     qtile.focus_screen(0)

@lazy.function
def focus_left(qtile):
    """Focus dp-0 left monitor"""
    if len(qtile.screens) == 1:
        qtile.focus_screen(qtile.current_screen.previous_group)
        return

    screen_affinity = qtile.current_screen.group.screen_affinity
    
    if screen_affinity == DP_2:
        qtile.focus_screen(1)

    # if qtile.current_screen.index == 0:
    #     qtile.focus_screen(2)
    # elif qtile.current_screen.index == 1:
    #     qtile.focus_screen(0)
    # else:
    #     qtile.focus_screen(qtile.current_screen.previous_group)
    #
@lazy.function
def focus_right(qtile):
    """Focus dp-2 right monitor"""
    if len(qtile.screens) == 1:
        qtile.focus_screen(qtile.current_screen.next_group)
        return

    screen_affinity = qtile.current_screen.group.screen_affinity
    
    if screen_affinity == DP_0:
        qtile.focus_screen(0)


    # if qtile.current_screen.index == 2:
    #     qtile.focus_screen(0)
    # elif qtile.current_screen.index == 0:
    #     qtile.focus_screen(1)
    # else:
    #     qtile.focus_screen(qtile.current_screen.next_group)
    #

## group setup ##


# def go_to_group(name: str):
#     def _inner(qtile):
#         if len(qtile.screens) == 1:
#             qtile.groups_map[name].toscreen()
#             return
#         start_group = qtile.current_screen.group.name
#         if start_group == name:
#             return
#         else:
#             qtile.go_to_group(name)
#         return _inner
#
# for i in groups:
#     keys.append(Key([mod], i.name, lazy.function(go_to_group(i.name))))
#     keys.append(Key([mod, "shift"], i.name, lazy.window.togroup(i.name)))
#



# def toscreen(qtile, group_name):
#     if group_name  == qtile.current_screen.group.name:
#         return qtile.current_screen.set_group(qtile.current_screen.previous_group)
#     
#     #loop through the odd(1,3,5,7) groups when DP-0 is the current screen
#     if qtile.current_screen.group.screen_affinity == 2:
#         for i, group in enumerate(qtile.groups):
#             if group_name == group.name and i % 2 != 0:
#                 return qtile.current_screen.set_group(qtile.groups[i])
#     #loop through the even(2,4,6,8) groups when DP-2 is the current screen
#     elif qtile.current_screen.group.screen_affinity == 0:
#         for i, group in enumerate(qtile.groups):
#             if group_name == group.name and i % 2 == 0:
#                 return qtile.current_screen.set_group(qtile.groups[i])
#
#     #for i, group in enumerate(qtile.groups):
#         # if group_name == group.name:
#         #     return qtile.current_screen.set_group(qtile.groups[i])
#
#
# for i in groups:
#     keys.extend([
#         # mod1 + letter of group = switch to group
#         #Key([mod], i.name, lazy.group[i.name].toscreen()),
#         # switch to group with ability to go to prevous group if pressed again
#         Key([mod], i.name, lazy.function(toscreen, i.name)),
#
#         # mod1 + shift + letter of group = switch to & move focused window to group
#         Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
#     ])



# Assuming you have other configurations and main loop for Qtile




# def go_to_group(name: str):
#     def _inner(qtile):
#         if len(qtile.screens) == 1:
#             qtile.groups_map[name].toscreen()
#             return
#
#         start_group = qtile.current_screen.group.name
#         if start_group == name:
#             return
#         else:
#             qtile.go_to_group(name)
#
#
#         # if name in '1':
#         #     qtile.focus_screen(2) # DP-0
#         #     qtile.groups_map[name].toscreen()
#         # elif name in '2':
#         #     qtile.focus_screen(0) # DP-2
#         #     qtile.groups_map[name].toscreen()
#         # # elif name in '3':
#         # #     qtile.focus_screen(1) # HDMI-0
#         # #     qtile.groups_map[name].toscreen()
#         # else:
#         #     qtile.groups_map[name].toscreen()
#
#         return _inner
#
# for i in groups:
#     keys.append(Key([mod], i.name, lazy.function(go_to_group(i.name))))
#
#
# # Add keybindings for moving windows to groups, e.g. to move window to group 1 use mod+shift+1
# def go_to_group_and_move_window(name: str):
#     def _inner(qtile):
#         if len(qtile.screens) == 1:
#             qtile.current_window.togroup(name, switch_group=True)
#             return        
#         
#         # # Find screen_affinity use that index to send to the right monitor
#         # if name in '1':
#         #     qtile.current_window.togroup(name, switch_group=False)
#         #     qtile.focus_screen(2) # DP-0
#         #     qtile.groups_map[name].toscreen()
#         # elif name in '2':
#         #     qtile.current_window.togroup(name, switch_group=False)
#         #     qtile.focus_screen(0) # DP-2
#         #     qtile.groups_map[name].toscreen()
#         # # elif name in '3':
#         # #     qtile.current_window.togroup(name, switch_group=False)
#         # #     qtile.focus_screen(1) # HDMI-0
#         # #     qtile.groups_map[name].toscreen()
#         # else:
#         #     qtile.current_window.togroup(name, switch_group=True)
#
#         return _inner
#
# for i in groups:
#     keys.append(Key([mod, "shift"], i.name, lazy.function(go_to_group_and_move_window(i.name))))
#
