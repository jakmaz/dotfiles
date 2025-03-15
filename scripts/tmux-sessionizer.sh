#!/usr/bin/env bash
if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find ~/git -mindepth 1 -maxdepth 1 -type d | fzf)
fi
if [[ -z $selected ]]; then
  exit 0
fi
selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  # Create a new session with neovim in the first window
  tmux new-session -s $selected_name -c $selected -n "nvim" "nvim"
  # Create a second window for terminal
  tmux new-window -t $selected_name:1 -n "terminal" -c $selected
  # Switch back to the first window
  tmux select-window -t $selected_name:0
  exit 0
fi

if ! tmux has-session -t=$selected_name 2>/dev/null; then
  # Create a detached session with neovim in the first window
  tmux new-session -ds $selected_name -c $selected -n "  nvim" "nvim"
  # Create a second window for terminal
  tmux new-window -t $selected_name:1 -n "  terminal" -c $selected
  # Switch back to the first window
  tmux select-window -t $selected_name:0
fi

tmux switch-client -t $selected_name
