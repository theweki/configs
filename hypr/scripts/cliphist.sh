#!/usr/bin/env bash

list_command="cliphist list"
copy_command="cliphist decode | wl-copy"
wipe_command="cliphist wipe"

selected_item=$(echo -e "Delete All History\n$(eval $list_command)" | rofi -dmenu -i -p "Clipboard History")

if [ "$selected_item" = "Delete All History" ]; then
    eval $wipe_command
elif [ -n "$selected_item" ]; then
    echo "$selected_item" | eval $copy_command
fi
