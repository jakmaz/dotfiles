#!/bin/bash

# Add event to subscribe
sketchybar --add event aerospace_workspace_change

# Define your spaces with names and corresponding Nerd Font icons
SPACES=("home:" "web:󰖟" "code:" "chat:󰍩" "music:󰎆")

# Add and configure spaces
for SPACE in "${SPACES[@]}"; do
  WORKSPACE_NAME=${SPACE%%:*} # Extract name (everything before ':')
  ICON=${SPACE##*:}           # Extract icon (everything after ':')

  # Add and set space
  sketchybar --add item "workspace.$WORKSPACE_NAME" left \
    --subscribe "workspace.$WORKSPACE_NAME" aerospace_workspace_change \
    --set "workspace.$WORKSPACE_NAME" \
    icon="$ICON" \
    label="$WORKSPACE_NAME" \
    icon.padding_right=5 \
    label.y_offset=-1 \
    click_script="aerospace workspace $WORKSPACE_NAME" \
    script="$PLUGIN_DIR/aerospace.sh $WORKSPACE_NAME"
done
