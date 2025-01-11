#!/bin/bash

wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
VOLUME_X=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
VOLUME=$(awk "BEGIN {printf \"%.0f\", $VOLUME_X * 100}")
ISMUTE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')
if [[ "$ISMUTE" == "[MUTED]" ]]; then
    notify-send "            MUTED !" --expire-time=1500 --app-name=VOLUME --replace-id=30 --icon="/home/adi/zzz/scripts/volume/icons/mute.svg"
else
    notify-send "               $VOLUME %" --expire-time=1500 --app-name=VOLUME --replace-id=30 --icon="/home/adi/zzz/scripts/volume/icons/volume_up.svg"
fi
