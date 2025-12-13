#!/bin/bash

# Kanata Toggle Script
# Toggles Kanata on/off and updates SketchyBar

CONFIG_FILE="$HOME/.config/kanata/colemak.kbd"
PID_FILE="/tmp/kanata.pid"
LOG_FILE="/tmp/kanata-toggle.log"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to check if Kanata is running
is_kanata_running() {
    if [ -f "$PID_FILE" ]; then
        local pid=$(cat "$PID_FILE")
        if ps -p "$pid" > /dev/null 2>&1; then
            # Check if it's actually kanata-cmd
            if ps -p "$pid" -o comm= | grep -q "kanata-cmd"; then
                return 0
            else
                # PID file exists but process is not kanata-cmd, clean up
                rm -f "$PID_FILE"
            fi
        else
            # PID file exists but process is dead, clean up
            rm -f "$PID_FILE"
        fi
    fi

    # Fallback: check for any kanata-cmd process
    pgrep -f "kanata-cmd.*colemak.kbd" > /dev/null 2>&1
}

# Function to start Kanata
start_kanata() {
    log "Starting Kanata..."

    # Kill any existing kanata processes first
    sudo pkill -f "kanata-cmd" 2>/dev/null || true
    sleep 1

    # Start kanata in background
    sudo kanata-cmd -c "$CONFIG_FILE" > /dev/null 2>&1 &

    # Wait a moment to ensure it started properly
    sleep 2

    # Get the actual kanata-cmd PID and save it
    local actual_pid=$(pgrep -f "kanata-cmd.*colemak.kbd" | head -1)
    if [ -n "$actual_pid" ]; then
        echo "$actual_pid" > "$PID_FILE"
        log "Kanata started successfully (PID: $actual_pid)"
        return 0
    else
        log "Failed to start Kanata"
        rm -f "$PID_FILE"
        return 1
    fi
}

# Function to stop Kanata
stop_kanata() {
    log "Stopping Kanata..."

    # Kill by PID if we have it
    if [ -f "$PID_FILE" ]; then
        local pid=$(cat "$PID_FILE")
        sudo kill "$pid" 2>/dev/null || true
        rm -f "$PID_FILE"
    fi

    # Ensure all kanata processes are killed
    sudo pkill -f "kanata-cmd" 2>/dev/null || true

    sleep 1

    if ! is_kanata_running; then
        log "Kanata stopped successfully"
        return 0
    else
        log "Failed to stop Kanata completely, but continuing..."
        return 0  # Don't fail if some processes remain
    fi
}

# Function to toggle Kanata
toggle_kanata() {
    if is_kanata_running; then
        stop_kanata
    else
        start_kanata
    fi
}

# Function to get Kanata status
get_status() {
    if is_kanata_running; then
        echo "running"
    else
        echo "stopped"
    fi
}

# Update SketchyBar
update_sketchybar() {
    sketchybar --trigger kanata_update
}

# Main logic
case "${1:-toggle}" in
    "start")
        start_kanata
        update_sketchybar
        ;;
    "stop")
        stop_kanata
        update_sketchybar
        ;;
    "toggle")
        toggle_kanata
        update_sketchybar
        ;;
    "status")
        get_status
        ;;
    *)
        echo "Usage: $0 {start|stop|toggle|status}"
        echo "Current status: $(get_status)"
        exit 1
        ;;
esac
