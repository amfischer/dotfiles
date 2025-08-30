#!/bin/zsh

SESSION="coid"
WORKDIR="$HOME/projects/coid-app/"

# Check if the session already exists
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  # Main window (create the session in detached mode)
  tmux new-session -d -s $SESSION -n main -c "$WORKDIR"

  # Git window
  tmux new-window -t $SESSION -n git -c "$WORKDIR"

  # Code window
  tmux new-window -t $SESSION -n code -c "$WORKDIR"

  # Misc window
  tmux new-window -t $SESSION -c "$WORKDIR"

  # check git status
  tmux set-hook -t "$SESSION" client-attached \
    "run-shell 'sleep 3; tmux send-keys -t $SESSION:git \"git status\" C-m"
fi

# Attach to the session
tmux select-window -t "$SESSION:main"
tmux attach -t $SESSION
