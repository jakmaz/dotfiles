#!/bin/bash

sketchybar --add item media center \
  --set media label.color=$ACCENT_COLOR \
  label.max_chars=60 \
  icon.padding_left=0 \
  icon=󰎇 \
  icon.color=$ACCENT_COLOR \
  background.drawing=off \
  click_script="open -a Spotify" \
  script="$PLUGIN_DIR/media.sh" \
  --subscribe media media_change
