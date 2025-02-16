#!/bin/bash

is_image() {
    case "${1##*.}" in
        jpg|jpeg|png|gif|webp) return 0 ;;
        *) return 1 ;;
    esac
}

CLIPBOARD_CONTENT=$(wl-paste)

if [[ -n "$CLIPBOARD_CONTENT" && -f "$CLIPBOARD_CONTENT" ]] && is_image "$CLIPBOARD_CONTENT"; then
    WALL="$CLIPBOARD_CONTENT"
else
    WALL=$(find "$HOME/pictures/walls/" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | shuf -n 1)
fi

## pywal
# rm -rf ~/.cache/wal/*
wal -i "$WALL"
hyprctl reload

## swww
swww img "$WALL" --transition-step 20 --transition-fps 60 --transition-type any &

# echo "$(date +'%Y-%m-%d %H:%M:%S') - $WALL" >> "$HOME/pictures/walls/recent_walls.txt"
echo $WALL > "$HOME/pictures/walls/current_wall.txt"

## apps
nohup pywalfox update > /dev/null
nohup walogram -s > /dev/null

## hyprpaper
sed -i "4s|path = .*|path = $WALL|" ~/.config/hypr/hyprlock.conf

## waybar
killall -SIGUSR2 waybar

## hyprpaper & hyprlock
# sed -i "s|^wallpaper =.*|wallpaper = ,$WALL|" ~/.config/hypr/hyprpaper.conf
# sed -i "s|^preload =.*|preload = $WALL|" ~/.config/hypr/hyprpaper.conf
# pkill hyprpaper
# nohup hyprpaper &> /dev/null &

# notify-send --app-name=Wallpaper --expire-time=4000 --icon="$WALL" "Wallpaper" "New wallpaper applied!"

# kill -9 $PPID
