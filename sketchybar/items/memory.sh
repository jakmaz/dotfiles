#!/bin/bash

# Initialization
sketchybar --add item memory right

# Config
sketchybar --set memory icon=􀫦  update_freq=10 script="$PLUGIN_DIR/memory.sh"
sketchybar --set memory icon.font="Hack Nerd Font:Bold:14"
