#!/bin/bash

sketchybar --add item volume right \
    --set volume script="$PLUGIN_DIR/volume.nu" \
    label.drawing=off \
    click_script="$PLUGIN_DIR/volume.nu" \
    --subscribe volume volume_change mouse.clicked bluetooth_update system_woke
