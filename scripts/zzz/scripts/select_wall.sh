WALLPAPER_DIR="$HOME/pictures/walls/best"

WALL=$(ls "$WALLPAPER_DIR" | rofi -dmenu -replace -config ~/.config/rofi/config-wallpaper.rasi -p "Select wallpaper : " )
 
if [ -n "$WALL" ]; then
    echo "$WALLPAPER_DIR/$WALL" | wl-copy
    bash $HOME/zzz/scripts/new_wall.sh &
fi
