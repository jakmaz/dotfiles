#!/bin/bash

# Get downlink capacity using networkQuality
downlink_capacity=$(networkQuality -s | grep "Downlink capacity" | awk '{print $3}')

# Check if we got a value
if [ -n "$downlink_capacity" ]; then
  # Format the speed (e.g., "79.6M")
  speed="$(printf "%.1f" "$downlink_capacity")M"
else
  speed="N/A"
fi

sketchybar --set $NAME label="$speed"
