#!/bin/bash

sketchybar --add item volume right \
    --set volume script="$PLUGIN_DIR/volume.nu" \
    click_script="$PLUGIN_DIR/volume.nu" \
    --subscribe volume volume_change mouse.clicked
