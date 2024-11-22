#!/bin/bash

# Define your spaces with names and corresponding Nerd Font icons
SPACES=("home:" "web:󰖟" "code:" "chat:󰍩" "music:󰎆")

# Add and configure spaces
for SPACE in "${SPACES[@]}"; do
  WORKSPACE_NAME=${SPACE%%:*} # Extract name (everything before ':')
  ICON=${SPACE##*:}           # Extract icon (everything after ':')

  # Add and set space
  sketchybar --add item "$WORKSPACE_NAME" left \
    --set "$WORKSPACE_NAME" \
    icon="$ICON" \
    label="$WORKSPACE_NAME" \
    icon.padding_right=5 \
    label.y_offset=-1
done
