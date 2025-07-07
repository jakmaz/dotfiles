let width = (yabai -m query --displays | from json | get 0.frame.w)

if $width >= 3440 {
    # UWQHD or larger: use bigger top padding
    yabai -m config top_padding 40
    yabai -m config bottom_padding 5
    yabai -m config left_padding 5
    yabai -m config right_padding 5
    yabai -m config window_gap 5
} else {
    # Smaller display: use larger padding
    yabai -m config top_padding 0
    yabai -m config bottom_padding 5
    yabai -m config left_padding 5
    yabai -m config right_padding 5
    yabai -m config window_gap 5
}
