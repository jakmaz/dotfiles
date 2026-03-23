#!/usr/bin/env nu

# Check if AirPods are connected
def check_airpods [] {
    let result = (
        ^system_profiler SPBluetoothDataType 
        | complete
    )

    if $result.exit_code == 0 {
        # Extract only the "Connected:" section
        let connected_section = (
            $result.stdout
            | lines
            | skip until {|line| $line | str contains "Connected:"}
            | take until {|line| $line | str contains "Not Connected:"}
            | str join "\n"
        )
        
        # Check if AirPods appear in the connected section
        $connected_section | str contains -i "airpods"
    } else {
        false
    }
}

# Handle click events for mute toggle
if $env.SENDER? == "mouse.clicked" {
    if $env.BUTTON? == "right" {
        # Right click: Toggle mute
        ^osascript -e '
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
    }
}

# Check if AirPods are connected
let airpods_connected = (check_airpods)

# If AirPods are connected, show AirPods icon only
if $airpods_connected {
    ^sketchybar --set $env.NAME icon="􀪷" label=""
    exit 0
}

# Get volume level and mute state
let volume = if $env.SENDER? == "volume_change" {
    $env.INFO | into int
} else {
    ^osascript -e "output volume of (get volume settings)" | str trim | into int
}

let muted = (
    ^osascript -e "output muted of (get volume settings)" 
    | str trim 
    | $in == "true"
)

# Update icon based on volume level and mute state
let icon = if $muted {
    "􀊣"  # Muted icon
} else if $volume >= 80 {
    "􀊩"  # High volume
} else if $volume >= 60 {
    "􀊧"  # High volume
} else if $volume >= 30 {
    "􀊥"  # Medium volume
} else if $volume >= 1 {
    "􀊡"  # Low volume
} else {
    "􀊣"  # Zero volume
}

^sketchybar --set $env.NAME $"icon=($icon)" label=""
