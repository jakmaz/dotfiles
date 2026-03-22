#!/usr/bin/env sh

# Handle hover events
if [ "$SENDER" = "mouse.entered" ]; then
    # Mouse entered: Animate bottom border (underline) appearance
    sketchybar --animate tanh 15 \
        --set "$NAME" \
            background.border_width=2 \
            background.border_color=0xffffffff \
            background.border_position=bottom
    exit 0
elif [ "$SENDER" = "mouse.exited" ]; then
    # Mouse exited: Animate bottom border away
    sketchybar --animate tanh 15 \
        --set "$NAME" \
            background.border_width=0 \
            background.border_color=0x00000000
    exit 0
fi

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
