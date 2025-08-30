#!/bin/zsh

SESSION="kahtoola"
WORKDIR="$HOME/projects/kahtoola/"

# Check if the session already exists
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  # Main window (create the session in detached mode)
  tmux new-session -d -s $SESSION -n main -c "$WORKDIR"

  # Git window
  tmux new-window -t $SESSION -n git -c "$WORKDIR"

  # Code window
  tmux new-window -t $SESSION -n code -c "$WORKDIR"

  # switch to node LTS v20 and check stencil version
  tmux set-hook -t "$SESSION" client-attached \
    "run-shell 'sleep 3; \
    tmux send-keys -t $SESSION:main \"nvm use 20\" C-m; \
    tmux send-keys -t $SESSION:git \"git status\" C-m; \
    sleep 1; \
    tmux send-keys -t $SESSION:main \"stencil -V\" C-m"
fi

# Attach to the session
tmux select-window -t "$SESSION:main"
tmux attach -t $SESSION
