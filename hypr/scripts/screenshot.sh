#!/usr/bin/env bash

DIR="$HOME/Pictures/screenshots"

if [ ! -d "$DIR" ]; then
  mkdir -p "$DIR"
fi

FILE="$DIR/screenshot_$(date +%Y%m%d_%H%M%S).png"

if [ "$1" = "slurp" ]; then
  grim -g "$(slurp)" "$FILE"
else
  grim "$FILE"
fi

if [ $? -eq 0 ]; then
  notify-send "Screenshot Taken"
else
  notify-send "Failed Screenshot"
fi