#!/bin/bash

sketchybar --add item pomodoro right \
    --set pomodoro update_freq=1 \
    script="$PLUGIN_DIR/pomodoro.sh" \
    click_script="$PLUGIN_DIR/pomodoro.sh" \
    --subscribe pomodoro mouse.clicked \
    --set pomodoro icon.font="Hack Nerd Font:Bold:14"

