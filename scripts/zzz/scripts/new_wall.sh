#!/bin/bash

# Function to check if a file has an image extension
is_image() {
    case "${1##*.}" in
        jpg|jpeg|png|gif|webp) return 0 ;;
        *) return 1 ;;
    esac
}

# Get the clipboard content
CLIPBOARD_CONTENT=$(wl-paste)

# Check if clipboard content is a valid image file
if [[ -n "$CLIPBOARD_CONTENT" && -f "$CLIPBOARD_CONTENT" ]] && is_image "$CLIPBOARD_CONTENT"; then
    WALL="$CLIPBOARD_CONTENT"
else
    # Pick a random file from the specified directory
    WALL=$(find "$HOME/pictures/walls/" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | shuf -n 1)
fi

## pywal
rm -rf ~/.cache/wal/*
wal -i "$WALL"

## swww & pywal
swww img "$WALL" --transition-step 60 --transition-fps 60 --transition-type any &

## pywal in applications
nohup pywalfox update > /dev/null
nohup walogram -s > /dev/null

## waybar
killall -SIGUSR2 waybar

## hyprpaper/swww & hyprlock
# sed -i "s|^wallpaper =.*|wallpaper = ,$WALL|" ~/.config/hypr/hyprpaper.conf
# sed -i "s|^preload =.*|preload = $WALL|" ~/.config/hypr/hyprpaper.conf
sed -i "4s|path = .*|path = $WALL|" ~/.config/hypr/hyprlock.conf
# pkill hyprpaper
# nohup hyprpaper &> /dev/null &

sleep 2

# notify-send --app-name=Wallpaper --expire-time=4000 --icon="$WALL" "Wallpaper" "New wallpaper applied!"

kill -9 $PPID
