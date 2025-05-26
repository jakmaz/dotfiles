#!/bin/bash

# Initialization
sketchybar --add item cpu right

# Config
sketchybar --set cpu icon=  update_freq=2 script="$PLUGIN_DIR/cpu.sh"
