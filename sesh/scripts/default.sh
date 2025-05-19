tmux send-keys -t 0 "nvim" Enter  # start nvim in window 0
tmux new-window -d                # create new window in background (window 1)
tmux select-window -t 0           # go back to window 0 (nvim)
