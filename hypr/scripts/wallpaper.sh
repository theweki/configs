#!/usr/bin/env bash

WALLPAPERS_PATH=$HOME/backgrounds/
NEW_WALL=$(ls $HOME/backgrounds/ | rofi -show -dmenu)

echo '' > $HOME/.config/hypr/hyprpaper.conf #Clear
echo "preload=$WALLPAPERS_PATH$NEW_WALL" >> $HOME/.config/hypr/hyprpaper.conf #Preload
echo "wallpaper=,$WALLPAPERS_PATH$NEW_WALL" >> $HOME/.config/hypr/hyprpaper.conf #Set

killall hyprpaper
hyprpaper &
