#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(
    find ~/git -mindepth 1 -maxdepth 1 -type d |
      fzf \
        --margin=2,10% \
        --border=rounded \
        --layout=reverse \
        --preview 'tree -C {} | head -100' \
        --preview-window=right:50% \
        --info=inline
  )
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s "$selected_name" -c "$selected" -n "nvim" "nvim"
  tmux new-window -t "$selected_name":1 -n "terminal" -c "$selected"
  tmux select-window -t "$selected_name":0
  exit 0
fi

if ! tmux has-session -t="$selected_name" 2>/dev/null; then
  tmux new-session -ds "$selected_name" -c "$selected" -n "  nvim" "nvim"
  tmux new-window -t "$selected_name":1 -n "  terminal" -c "$selected"
  tmux select-window -t "$selected_name":0
fi

tmux switch-client -t "$selected_name"
