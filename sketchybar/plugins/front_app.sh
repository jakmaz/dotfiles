#!/bin/sh

source "$CONFIG_DIR/plugins/icon_map.sh"  # source the script so __icon_map is loaded

if [ "$SENDER" = "front_app_switched" ]; then
  __icon_map "$INFO"                 # call the function which sets icon_result
  sketchybar --set "$NAME" label="$INFO" icon="$icon_result"
fi
