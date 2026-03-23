#!/bin/bash

sketchybar --add item kanata right \
    --set kanata update_freq=30 \
    script="$PLUGIN_DIR/kanata.sh" \
    icon=  \
    icon.font="Hack Nerd Font:Bold:14" \
    icon.color=0xff666666 \
    padding_left=10 \
    label.drawing=off \
    click_script="$PLUGIN_DIR/kanata.sh" \
    --subscribe kanata mouse.clicked kanata_update
