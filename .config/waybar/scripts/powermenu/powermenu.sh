#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5

# Current Theme
dir="$HOME/.config/waybar/scripts/powermenu"
theme='style-1'

# CMDs
if command -v uptime &>/dev/null && uptime -p &>/dev/null; then
    uptime="$(uptime -p | sed -e 's/^up //')"
else
    uptime=$(uptime | sed -e 's/.* up //' -e 's/,.*//' -e 's/ *\(.*\)/\1/')
fi
host=$(hostname)

# Options
shutdown=' Shutdown'
reboot=' Reboot'
lock=' Lock'
suspend=' Suspend'
logout=' Logout'
yes=' Yes'
no=' No'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "$host" \
        -mesg "Uptime: $uptime" \
        -theme "${dir}/${theme}.rasi"
}

# Confirmation CMD
confirm_cmd() {
    rofi -theme-str 'window {location: northeast; anchor: northeast; fullscreen: false; width: 250px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme "${dir}/${theme}.rasi"
}

# Ask for confirmation
confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        case $1 in
            --shutdown)
                systemctl poweroff
                ;;
            --reboot)
                systemctl reboot
                ;;
            --suspend)
                playerctl -a pause
                amixer set Master mute
                systemctl suspend
                ;;
            --logout)
                if pgrep "hyprland" >/dev/null; then
                    hyprctl dispatch exit
                elif pgrep "qtile" >/dev/null; then
                    qtile cmd-obj -o cmd -f shutdown
                else
                    case "$DESKTOP_SESSION" in
                        openbox)
                            openbox --exit
                            ;;
                        bspwm)
                            bspc quit
                            ;;
                        i3)
                            i3-msg exit
                            ;;
                        plasma)
                            qdbus org.kde.ksmserver /KSMServer logout 0 0 0
                            ;;
                        *)
                            loginctl terminate-session "${XDG_SESSION_ID-}"
                            ;;
                    esac
                fi
                ;;
        esac
    else
        exit 0
    fi
}

# Actions
chosen="$(run_rofi)"
case "${chosen}" in
    "$shutdown")
        run_cmd --shutdown
        ;;
    "$reboot")
        run_cmd --reboot
        ;;
    "$lock")
        if pgrep "Hyprland" >/dev/null; then
            # Try multiple lock methods for NixOS compatibility
            if command -v swaylock >/dev/null; then
                swaylock \
                    --screenshots \
                    --clock \
                    --indicator \
                    --effect-blur 7x5 \
                    --effect-vignette 0.5:0.5 \
                    --ring-color bb00cc \
                    --key-hl-color 880033 \
                    --line-color 00000000 \
                    --inside-color 00000088 \
                    --separator-color 00000000 \
                    --fade-in 0.2
            elif command -v hyprlock >/dev/null; then
                hyprlock
            else
                notify-send "Lock Error" "No supported locker found (tried swaylock/hyprlock)"
            fi
        elif pgrep "qtile" >/dev/null; then
            i3lock -c 000000
        else
            if [[ -x '/usr/bin/betterlockscreen' ]]; then
                betterlockscreen -l
            elif [[ -x '/usr/bin/i3lock' ]]; then
                i3lock
            fi
        fi
        ;;
    "$suspend")
        run_cmd --suspend
        ;;
    "$logout")
        run_cmd --logout
        ;;
esac
