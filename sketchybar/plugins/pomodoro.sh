#!/bin/bash

STATE_FILE="/tmp/pomodoro_state"
SIT_DURATION=1200  # 20 minutes in seconds
STAND_DURATION=600  # 10 minutes in seconds

# Initialize state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo '{"running":false,"mode":"sit","end_time":0}' > "$STATE_FILE"
fi

# Read current state
STATE=$(cat "$STATE_FILE")
RUNNING=$(echo "$STATE" | jq -r '.running')
MODE=$(echo "$STATE" | jq -r '.mode')
END_TIME=$(echo "$STATE" | jq -r '.end_time')

# Handle mouse click events
if [ "$SENDER" = "mouse.clicked" ]; then
    case "$BUTTON" in
        "left")
            # Toggle running/stopped
            if [ "$RUNNING" = "true" ]; then
                # Stop the timer - animate icon pulse
                echo '{"running":false,"mode":"sit","end_time":0}' > "$STATE_FILE"
                sketchybar --animate tanh 15 --set "$NAME" icon.scale=1.3 icon.scale=1.0
            else
                # Start fresh with 20 min sit - animate icon pop
                END_TIME=$(($(date +%s) + SIT_DURATION))
                echo "{\"running\":true,\"mode\":\"sit\",\"end_time\":$END_TIME}" > "$STATE_FILE"
                sketchybar --animate tanh 20 --set "$NAME" icon.y_offset=-5 icon.y_offset=0
            fi
            ;;
        "right")
            # Skip to next session (only if running)
            if [ "$RUNNING" = "true" ]; then
                if [ "$MODE" = "sit" ]; then
                    END_TIME=$(($(date +%s) + STAND_DURATION))
                    echo "{\"running\":true,\"mode\":\"stand\",\"end_time\":$END_TIME}" > "$STATE_FILE"
                else
                    END_TIME=$(($(date +%s) + SIT_DURATION))
                    echo "{\"running\":true,\"mode\":\"sit\",\"end_time\":$END_TIME}" > "$STATE_FILE"
                fi
                # Animate icon bounce on skip
                sketchybar --animate sin 25 --set "$NAME" icon.y_offset=-8 icon.y_offset=0
            fi
            ;;
    esac

    # Re-read state after potential change
    STATE=$(cat "$STATE_FILE")
    RUNNING=$(echo "$STATE" | jq -r '.running')
    MODE=$(echo "$STATE" | jq -r '.mode')
    END_TIME=$(echo "$STATE" | jq -r '.end_time')
fi

# Update display based on current state
if [ "$RUNNING" = "false" ]; then
    # Paused state
    sketchybar --set "$NAME" icon="⏸" label="PAUSED"
else
    # Running - calculate time left
    CURRENT_TIME=$(date +%s)
    TIME_LEFT=$((END_TIME - CURRENT_TIME))

    if [ $TIME_LEFT -le 0 ]; then
        # Timer expired - switch mode, play sound, and animate
        if [ "$MODE" = "sit" ]; then
            # Switch to stand
            END_TIME=$((CURRENT_TIME + STAND_DURATION))
            echo "{\"running\":true,\"mode\":\"stand\",\"end_time\":$END_TIME}" > "$STATE_FILE"
            afplay /System/Library/Sounds/Glass.aiff &
            MODE="stand"
            TIME_LEFT=$STAND_DURATION
            # Animate icon pop on mode switch
            sketchybar --animate tanh 25 --set "$NAME" icon.y_offset=-10 icon.y_offset=0
        else
            # Switch to sit
            END_TIME=$((CURRENT_TIME + SIT_DURATION))
            echo "{\"running\":true,\"mode\":\"sit\",\"end_time\":$END_TIME}" > "$STATE_FILE"
            afplay /System/Library/Sounds/Glass.aiff &
            MODE="sit"
            TIME_LEFT=$SIT_DURATION
            # Animate icon pop on mode switch
            sketchybar --animate tanh 25 --set "$NAME" icon.y_offset=-10 icon.y_offset=0
        fi
    fi

    # Format time as MM:SS
    MINUTES=$((TIME_LEFT / 60))
    SECONDS=$((TIME_LEFT % 60))
    TIME_STR=$(printf "%02d:%02d" $MINUTES $SECONDS)

    # Set icon based on mode
    if [ "$MODE" = "sit" ]; then
        ICON=""
    else
        ICON=""
    fi

    sketchybar --set "$NAME" icon="$ICON" label="$TIME_STR"
fi
