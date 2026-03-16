#!/bin/bash

sketchybar --add item battery right \
    --set battery update_freq=120 \
    script="$PLUGIN_DIR/battery.sh" \
    --set battery icon.font="Hack Nerd Font:Bold:14" \
    --subscribe battery system_woke power_source_change
