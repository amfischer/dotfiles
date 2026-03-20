#!/bin/zsh

# --- Config ---
declare -A WORKDIRS=(
  [coid]="$HOME/projects/coid-app"
  [dotfiles]="$HOME/projects/dotfiles"
  [kahtoola]="$HOME/projects/kahtoola"
  [moblify]="$HOME/projects/moblify"
  [money]="$HOME/projects/expense-tracker"
  [renav]="$HOME/projects/renav-legacy"
  [renavtitle]="$HOME/projects/renav-title"
  [talon]="$HOME/projects/talon-bigcommerce"
)

declare -A BIG_COMMERCE=(
  [kahtoola]=1
  [talon]=1
)

# --- Resolve session ---
SESSION="$1"

if [[ -z "$SESSION" ]]; then
  echo "Usage: tmux-session <session-name>"
  echo "Available: ${(k)WORKDIRS}"
  exit 1
fi

WORKDIR="${WORKDIRS[$SESSION]}"

if [[ -z "$WORKDIR" ]]; then
  echo "Unknown session: $SESSION"
  echo "Available: ${(k)WORKDIRS}"
  exit 1
fi

# --- Create session if it doesn't exist ---
tmux has-session -t "$SESSION" 2>/dev/null

if [[ $? != 0 ]]; then
  tmux new-session -d -s "$SESSION" -n main -c "$WORKDIR"
  tmux new-window -t "$SESSION" -n git -c "$WORKDIR"
  tmux new-window -t "$SESSION" -n code -c "$WORKDIR"
  tmux new-window -t "$SESSION" -n agents -c "$WORKDIR"

  # Build startup commands
  local hooks="tmux send-keys -t $SESSION:git \"git status\" C-m"

  if [[ -n "${BIG_COMMERCE[$SESSION]}" ]]; then
    hooks="$hooks; tmux send-keys -t $SESSION:main \"nvm use 20\" C-m"
    hooks="$hooks; sleep 1; tmux send-keys -t $SESSION:main \"stencil -V\" C-m"
  fi

  tmux set-hook -t "$SESSION" client-attached \
    "run-shell 'sleep 3; $hooks'"
fi

# --- Attach ---
tmux select-window -t "$SESSION:main"
tmux attach -t "$SESSION"
