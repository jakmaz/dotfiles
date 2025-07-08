#!/bin/bash

sketchybar --add item wifi right \
           --set wifi update_freq=10 \
                      icon=󰖩 \
                      script="$PLUGIN_DIR/wifi.sh"

