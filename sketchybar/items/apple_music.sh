#!/bin/bash

# Initialization
sketchybar --add item apple_music center

# Config
APPLE_MUSIC_EVENT="com.apple.iTunes.playerInfo"
sketchybar --add event apple_music_change $APPLE_MUSIC_EVENT
sketchybar --set apple_music script="$PLUGIN_DIR/apple_music.sh"
sketchybar --subscribe apple_music apple_music_change

# Overrides of default settings
sketchybar --set apple_music background.border_color=0x00000000
sketchybar --set apple_music background.color=0x00000000
sketchybar --set apple_music background.border_width=0
