#!/bin/bash

# Radio Toggle Script
# Toggles BNR radio stream via mpv

RADIO_URL="https://stream.bnr.nl/bnr_aac_96_20"
PID_FILE="/tmp/mpv-radio.pid"

is_radio_playing() {
    if [ -f "$PID_FILE" ]; then
        local pid=$(cat "$PID_FILE")
        if ps -p "$pid" > /dev/null 2>&1; then
            return 0
        fi
        rm -f "$PID_FILE"
    fi
    pgrep -f "mpv.*stream.bnr.nl" > /dev/null 2>&1
}

start_radio() {
    mpv --no-video --idle=yes "$RADIO_URL" > /dev/null 2>&1 &
    echo $! > "$PID_FILE"
}

stop_radio() {
    if [ -f "$PID_FILE" ]; then
        kill $(cat "$PID_FILE") 2>/dev/null || true
        rm -f "$PID_FILE"
    fi
    pkill -f "mpv.*stream.bnr.nl" 2>/dev/null || true
}

toggle_radio() {
    if is_radio_playing; then
        stop_radio
    else
        start_radio
    fi
}

get_status() {
    if is_radio_playing; then
        echo "playing"
    else
        echo "stopped"
    fi
}

case "${1:-toggle}" in
    "start") start_radio ;;
    "stop") stop_radio ;;
    "toggle") toggle_radio ;;
    "status") get_status ;;
    *) echo "Usage: $0 {start|stop|toggle|status}" ;;
esac
