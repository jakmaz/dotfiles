#!/usr/bin/env sh

INFO=$(osascript -e '
  tell application "Music"
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
  sketchybar --set "$NAME" icon="" label="[jakmaz] "
else
  sketchybar --set "$NAME" icon="󰝚 " label="$INFO" drawing=on
fi
