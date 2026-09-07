#!/bin/zsh

# --- Config ---
declare -A WORKDIRS=(
  [coid]="$HOME/projects/coid-app"
  [dotfiles]="$HOME/projects/dotfiles"
  [dotfiles-private]="$HOME/projects/dotfiles-private"
  [kahtoola]="$HOME/projects/kahtoola"
  [moblify]="$HOME/projects/moblify"
  [money]="$HOME/projects/expense-tracker"
  [renav]="$HOME/projects/renav-legacy"
  [renavtitle]="$HOME/projects/renav-title"
  [talon]="$HOME/projects/talon-bigcommerce"
  [blue]="$HOME/projects/with-blue"
  [stay]="$HOME/projects/stay-with-blue"
)

declare -A NODE_VERSIONS=(
  [kahtoola]=22
  [talon]=22
  # [blue]=24
)

# BigCommerce projects: show `stencil -V` on the main window
declare -A STENCIL=(
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
  local hooks="true"

  local ran_nvm=""
  if [[ -n "${NODE_VERSIONS[$SESSION]}" ]]; then
    local node_version="${NODE_VERSIONS[$SESSION]}"
    for window in main git code agents; do
      hooks="$hooks; tmux send-keys -t $SESSION:$window \"nvm use $node_version\" C-m"
    done
    ran_nvm=1
  fi

  if [[ -n "$ran_nvm" ]]; then
    hooks="$hooks; sleep 1"
  fi

  hooks="$hooks; tmux send-keys -t $SESSION:git \"git status\" C-m"

  if [[ -n "${STENCIL[$SESSION]}" ]]; then
    hooks="$hooks; tmux send-keys -t $SESSION:main \"stencil -V\" C-m"
  fi

  tmux set-hook -t "$SESSION" client-attached \
    "run-shell 'sleep 3; $hooks'"
fi

# --- Attach ---
tmux select-window -t "$SESSION:main"
tmux attach -t "$SESSION"
