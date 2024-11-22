#!/bin/bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    background.border_width=1 \
    background.border_color=0xffffffff
else
  sketchybar --set "$NAME" \
    background.border_width=0 \
    background.border_color=0xff262626
fi
