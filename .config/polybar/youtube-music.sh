#!/bin/bash
song=$(playerctl metadata --format "{{ title }}")
echo "$song"
