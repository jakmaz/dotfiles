#!/bin/bash

# SketchyBar plugin for Kanata status

KANATA_SCRIPT="$HOME/.config/kanata/kanata-toggle.sh"

# Check if Kanata is running
if "$KANATA_SCRIPT" status | grep -q "running"; then
    KANATA_STATUS="running"
    COLOR="0xffffffff"  # White
else
    KANATA_STATUS="stopped"
    COLOR="0xff666666"  # Gray
fi

# Handle click events
if [ "$SENDER" = "mouse.clicked" ]; then
    # Toggle Kanata when clicked
    "$KANATA_SCRIPT" toggle > /dev/null 2>&1

    # Wait a moment for the toggle to complete
    sleep 1

    # Update status after toggle
    if "$KANATA_SCRIPT" status | grep -q "running"; then
        KANATA_STATUS="running"
        COLOR="0xffffffff"  # White
    else
        KANATA_STATUS="stopped"
        COLOR="0xff666666"  # Gray
    fi
fi

# Update the SketchyBar item
sketchybar --set "$NAME" icon.color="$COLOR" icon.padding_right=10
