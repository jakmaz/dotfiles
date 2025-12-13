#!/bin/sh

# Handle click events for mute toggle
if [ "$SENDER" = "mouse.clicked" ]; then
    case "$BUTTON" in
        "right")
            # Right click: Toggle mute
            osascript -e '
            tell application "System Events"
                set currentMute to (output muted of (get volume settings))
                if currentMute then
                    set volume output muted false
                else
                    set volume output muted true
                end if
            end tell
            '
            # Exit immediately - let system volume_change event handle the display update
            exit 0
            ;;
    esac
# Handle scroll events for volume control
elif [ "$SENDER" = "mouse.scrolled" ]; then
    # Get current volume
    CURRENT_VOLUME=$(osascript -e "output volume of (get volume settings)")

    # Calculate new volume based on scroll direction
    # $SCROLL_DELTA is positive for scroll up, negative for scroll down
    if [ "$SCROLL_DELTA" -gt 0 ]; then
        # Scroll up: increase volume by 10
        NEW_VOLUME=$((CURRENT_VOLUME + 10))
    else
        # Scroll down: decrease volume by 10
        NEW_VOLUME=$((CURRENT_VOLUME - 10))
    fi

    # Clamp volume between 0 and 100
    if [ "$NEW_VOLUME" -gt 100 ]; then
        NEW_VOLUME=100
    elif [ "$NEW_VOLUME" -lt 0 ]; then
        NEW_VOLUME=0
    fi

    # Set new volume and ensure it's not muted
    osascript -e "set volume output volume $NEW_VOLUME"
    osascript -e "set volume output muted false"

    # Update the display immediately for scroll events
    VOLUME="$NEW_VOLUME"
    MUTED="false"
fi

# Handle volume_change event (from system) or manual updates
if [ "$SENDER" = "volume_change" ]; then
    VOLUME="$INFO"
elif [ "$SENDER" != "mouse.scrolled" ]; then
    # Manual update or initialization - get current volume
    VOLUME=$(osascript -e "output volume of (get volume settings)")
fi

# Always get mute state for display updates (except for scroll which sets it explicitly)
if [ "$SENDER" != "mouse.scrolled" ]; then
    MUTED=$(osascript -e "output muted of (get volume settings)")
fi

# Update icon based on volume level and mute state
if [ "$MUTED" = "true" ]; then
    ICON="󰖁"  # Muted icon
else
    case "$VOLUME" in
        [6-9][0-9] | 100)
            ICON="󰕾"
            ;;
        [3-5][0-9])
            ICON="󰖀"
            ;;
        [1-9] | [1-2][0-9])
            ICON="󰕿"
            ;;
        *) ICON="󰖁" ;;
    esac
fi

sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
