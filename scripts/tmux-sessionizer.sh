#!/usr/bin/env bash

# Check if an argument is provided
if [[ $# -eq 1 ]]; then
  selected="$HOME/git/$1" # Use full path if argument is passed
else
  # Use fzf to select a project directory
  selected=$(
    find ~/git -mindepth 1 -maxdepth 1 -type d -print | 
      sed "s|$HOME/git/||" | # Display only project names in fzf
      fzf \
        --margin=2,10% \
        --border=rounded \
        --layout=reverse \
        --preview 'tree -C -I "node_modules" ~/git/{} | head -100' \
        --preview-window=right:50% \
        --info=inline
  )
  selected="$HOME/git/$selected" # Convert back to full path
fi

# Exit if no selection or the selection is not a directory
if [[ -z $selected || ! -d $selected ]]; then
  exit 0
fi

# Generate a session name from the selected directory
selected_name=$(basename "$selected" | tr . _)

# Check if tmux is running
tmux_running=$(pgrep tmux)

# If not inside TMUX and tmux is not running, start a new session
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s "$selected_name" -c "$selected" -n "nvim" \
    "nvim; nu" # Keep the pane open and start nushell after nvim exits
  tmux new-window -t "$selected_name":1 -n "terminal" -c "$selected"
  tmux select-window -t "$selected_name":0
  exit 0
fi

# Create a new session if it does not already exist
if ! tmux has-session -t="$selected_name" 2>/dev/null; then
  tmux new-session -ds "$selected_name" -c "$selected" -n "  nvim" \
    "nvim; nu" # Keep the pane open and start nushell after nvim exits
  tmux new-window -t "$selected_name":1 -n "  terminal" -c "$selected"
  tmux select-window -t "$selected_name":0
fi

# Switch to the session
tmux switch-client -t "$selected_name"
