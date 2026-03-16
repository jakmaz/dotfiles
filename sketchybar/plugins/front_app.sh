#!/bin/sh

source "$CONFIG_DIR/plugins/icon_map.sh"  # source the script so __icon_map is loaded

if [ "$SENDER" = "front_app_switched" ]; then
  __icon_map "$INFO"                 # call the function which sets icon_result
  
  # Calculate dynamic width based on app name length
  # Base width (for icon) + approx 8px per character + padding
  APP_NAME_LENGTH=${#INFO}
  WIDTH=$(( 20 + (APP_NAME_LENGTH * 8) + 20 ))
  
  # Animate the width change with tanh curve (smooth deceleration)
  sketchybar --animate tanh 20 \
    --set "$NAME" \
      label="$INFO" \
      icon="$icon_result" \
      width="$WIDTH"
fi
