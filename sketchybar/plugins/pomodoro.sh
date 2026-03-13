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
                # Stop the timer
                echo '{"running":false,"mode":"sit","end_time":0}' > "$STATE_FILE"
            else
                # Start fresh with 20 min sit
                END_TIME=$(($(date +%s) + SIT_DURATION))
                echo "{\"running\":true,\"mode\":\"sit\",\"end_time\":$END_TIME}" > "$STATE_FILE"
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
        # Timer expired - switch mode and notify
        if [ "$MODE" = "sit" ]; then
            # Switch to stand
            END_TIME=$((CURRENT_TIME + STAND_DURATION))
            echo "{\"running\":true,\"mode\":\"stand\",\"end_time\":$END_TIME}" > "$STATE_FILE"
            osascript -e 'display notification "Time to stand up!" with title "Pomodoro Timer"'
            MODE="stand"
            TIME_LEFT=$STAND_DURATION
        else
            # Switch to sit
            END_TIME=$((CURRENT_TIME + SIT_DURATION))
            echo "{\"running\":true,\"mode\":\"sit\",\"end_time\":$END_TIME}" > "$STATE_FILE"
            osascript -e 'display notification "Time to sit down!" with title "Pomodoro Timer"'
            MODE="sit"
            TIME_LEFT=$SIT_DURATION
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
