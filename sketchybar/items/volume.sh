#!/bin/bash

sketchybar --add item volume right \
  --set volume script="$PLUGIN_DIR/volume.sh" \
  click_script="$PLUGIN_DIR/volume.sh" \
  --subscribe volume volume_change mouse.scrolled mouse.clicked
