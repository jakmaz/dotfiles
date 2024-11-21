#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on \
    background.color=$ACCENT_COLOR \
    label.color=$BAR_COLOR \
    icon.color=$BAR_COLOR
else
  sketchybar --set $NAME background.drawing=off \
    label.color=$ACCENT_COLOR \
    icon.color=$ACCENT_COLOR
fi
