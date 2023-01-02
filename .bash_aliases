# Project Directories
alias kk='cd ..'
alias kkl='cd .. && ls -la'
alias ..='cd .. && ls -la'
alias ex.='explorer.exe .'
alias ll='ls -lah'

alias rj='cd ~/projects && ls -la'

# Docker Commands
alias dcu='docker-compose up'
alias dcd='docker-compose down'

alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

# Git Commands
alias gs='git status'
alias gf='git diff'
alias gb='git branch'
alias gcm='git checkout master'
alias gpom='git pull origin master'
alias gfp='git fetch --prune'

# Add ssh-key to the keychain
alias sh1='eval "$(ssh-agent -s)"'
alias sh2='ssh-add ~/.ssh/id_ed25519'

# This is specific to WSL 2. If the WSL 2 VM goes rogue and decides not to free
# up memory, this command will free your memory after about 20-30 seconds.
#   Details: https://github.com/microsoft/WSL/issues/4166#issuecomment-628493643
alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
