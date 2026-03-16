#!/usr/bin/env nu

let core_count = (sys cpu | length)
let current_user = (whoami | str trim)

let cpu_info = (
    ^ps -eo pcpu,user
    | lines
    | skip 1
    | each { |line| $line | str trim | split row -r '\s+' }
    | each { |row| { pcpu: ($row.0 | into float), user: $row.1 } }
)

let cpu_sys = (
    $cpu_info
    | where user != $current_user
    | get pcpu
    | math sum
    | $in / (100.0 * ($core_count | into float))
)

let cpu_user = (
    $cpu_info
    | where user == $current_user
    | get pcpu
    | math sum
    | $in / (100.0 * ($core_count | into float))
)

let cpu_percent = (($cpu_sys + $cpu_user) * 100 | math round | into int)

sketchybar --set $env.NAME $"label=($cpu_percent)%"
