#!/usr/bin/env sh

INFO=$(osascript -e '
  tell application "Spotify"
    if it is running and player state is playing then
      set trackName to name of current track
      set artistName to artist of current track
      return trackName & " – " & artistName
    else
      return ""
    end if
  end tell
')

if [ -z "$INFO" ]; then
  sketchybar --set "$NAME" icon=" " label.font="Hack Nerd Font:Bold:16.0" label="[jakmaz] "
else
  sketchybar --set "$NAME" label="$INFO" drawing=on
fi
