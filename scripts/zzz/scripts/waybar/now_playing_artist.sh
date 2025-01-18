#!/bin/bash

source ~/zzz/scripts/waybar/utils.sh

artist_name=$(playerctl metadata --format "{{ artist }}" 2>/dev/null)

if [ -z "$artist_name" ]; then
    printf "また一人で"
else
    truncated_artist=$(truncate_string "$artist_name")
    escaped_artist=$(escape_markup "$truncated_artist")
    printf "%s\n" "$escaped_artist"
fi
