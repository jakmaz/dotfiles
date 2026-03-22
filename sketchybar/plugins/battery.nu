#!/usr/bin/env nu

# Get battery information
let battery_info = (^pmset -g batt | str trim)

# Extract percentage
let percentage = (
    $battery_info 
    | parse -r '(\d+)%' 
    | get capture0? 
    | first 
    | default "0" 
    | into int
)

# Check if charging
let is_charging = ($battery_info | str contains "AC Power")

# Determine icon based on percentage and charging state
let icon = if $is_charging {
    "􀢋"
} else if $percentage >= 90 {
    "􀛨"
} else if $percentage >= 65 {
    "􀺸"
} else if $percentage >= 40 {
    "􀺶"
} else if $percentage >= 15 {
    "􀛪"
} else {
    "battery.0percent"
}

^sketchybar --set $env.NAME $"icon=($icon)" $"label=($percentage)%"
