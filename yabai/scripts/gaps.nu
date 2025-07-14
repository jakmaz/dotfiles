let display = (yabai -m query --displays | from json | get 0)
let width = $display.frame.w

if $width <= 1710 {
    # MacBook Air display
    yabai -m config top_padding 0
    yabai -m config bottom_padding 5
    yabai -m config left_padding 5
    yabai -m config right_padding 5
    yabai -m config window_gap 0
} else {
    # External display
    yabai -m config top_padding 40
    yabai -m config bottom_padding 5
    yabai -m config left_padding 5
    yabai -m config right_padding 5
    yabai -m config window_gap 5
}
