#!/usr/bin/env nu

# Check WiFi status by checking for assigned IP address
let wifi_status = (
    ^ipconfig getifaddr en0
    | complete
)

# If we have an IP address, WiFi is connected
let is_connected = ($wifi_status.exit_code == 0)

# Set icon based on connection status
let icon = if $is_connected {
    "􀙇"
} else {
    "􀙈"
}

^sketchybar --set $env.NAME $"icon=($icon)"
