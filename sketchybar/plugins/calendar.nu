#!/usr/bin/env nu

# Format: "Mon 17 Mar 14:30"
let date_string = (date now | format date "%a %d %b %H:%M")
sketchybar --set $env.NAME $"label=($date_string)"
