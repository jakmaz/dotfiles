#!/bin/bash

# Add the Apple logo item to the left side
sketchybar \
  --add item apple.logo left \
  --set apple.logo icon=󰀵 \
  icon.padding_right=8 \
  label.drawing=off \
  popup.height=30 \
  click_script="sketchybar -m --set \$NAME popup.drawing=toggle"

# Set default padding for items
sketchybar \
  --default background.padding_left=5 \
  background.padding_right=5 \
  icon.padding_right=5

# Add the Sleep item to the popup menu
sketchybar \
  --add item apple.sleep popup.apple.logo \
  --set apple.sleep icon=󰒲 \
  label="Sleep" \
  click_script="osascript -e 'tell application \"System Events\" to sleep'; \
                                   sketchybar -m --set apple.logo popup.drawing=off"

# Add the Restart item to the popup menu
sketchybar \
  --add item apple.restart popup.apple.logo \
  --set apple.restart icon=󰜉 \
  label="Restart" \
  click_script="osascript -e 'tell application \"System Events\" to restart'; \
                                    sketchybar -m --set apple.logo popup.drawing=off"

# Add the Shut Down item to the popup menu
sketchybar \
  --add item apple.shutdown popup.apple.logo \
  --set apple.shutdown icon=󰐥 \
  label="Shut Down" \
  click_script="osascript -e 'tell application \"System Events\" to shut down'; \
                                      sketchybar -m --set apple.logo popup.drawing=off"
