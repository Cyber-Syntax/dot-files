#!/usr/bin/env bash
pactl set-default-sink $(pactl list short sinks |awk '{print $2}' | rofi -dmenu -location 3)

