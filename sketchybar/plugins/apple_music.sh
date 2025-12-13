#!/usr/bin/env sh

# Handle click events
if [ "$SENDER" = "mouse.clicked" ]; then
    case "$BUTTON" in
        "left")
            # Left click: Open Music app
            open -a "Music"
            ;;
        "right")
            # Right click: Play/Pause toggle
            osascript -e '
            tell application "Music"
                if it is running then
                    if player state is playing then
                        pause
                    else
                        play
                    end if
                else
                    -- If Music app is not running, start it and play
                    activate
                    play
                end if
            end tell
            '
            ;;
    esac
    exit 0
fi

# Handle music info updates
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
  sketchybar --set "$NAME" label="[jakmaz]" icon.drawing=off
else
  sketchybar --set "$NAME" icon="󰝚 " label="$INFO" icon.drawing=on
fi
