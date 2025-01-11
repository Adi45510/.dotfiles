#!/bin/bash

wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
VOLUME_X=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
VOLUME=$(awk "BEGIN {printf \"%.0f\", $VOLUME_X * 100}")
if [[ "$VOLUME_X" == "0.00" ]]; then
    notify-send "            MUTED !" --expire-time=1500 --app-name=VOLUME --replace-id=30 --icon="/home/adi/zzz/scripts/volume/icons/mute.svg"
else
    notify-send "               $VOLUME %" --expire-time=1500 --app-name=VOLUME --replace-id=30 --icon="/home/adi/zzz/scripts/volume/icons/volume_down.svg"
fi
