#!/bin/bash

sketchybar --add item wifi right \
    --set wifi update_freq=10 \
    script="$PLUGIN_DIR/wifi.nu" \
    label.drawing=off \
    --subscribe wifi wifi_change system_woke

