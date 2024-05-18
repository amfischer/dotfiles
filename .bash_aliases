# Project Directories
alias kk='cd ..'
alias kkl='cd .. && ls -la'
alias ..='cd .. && ls -la'
alias ex.='explorer.exe .'
alias ll='ls -lah'
alias v='~/nvim.appimage'
alias vl='NVIM_APPNAME="nvim-laracasts" ~/nvim.appimage'
alias vk='NVIM_APPNAME="nvim-kickstart" ~/nvim.appimage'

alias rgf='rg --files | rg'

alias rj='cd ~/projects && ls -la'
alias not='cd ~/projects/notes-chrome-plugin/'
alias renav='cd ~/projects/renav-legacy/'
alias fitt='cd ~/projects/true-fitness-api/'
alias fittt='cd ~/projects/true-fitness/'
alias mtt='cd ~/projects/truefit-macro-wizard/'
alias kah='cd ~/projects/kahtoola/'
alias money='cd ~/projects/expense-tracker/'
alias coid='cd ~/projects/coid-app/'

# Docker Commands
alias dcu='docker-compose up'
alias dcd='docker-compose down'

alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

alias spd='sail pint --dirty'

# Git Commands
alias g='git'
alias gs='git status'
alias gf='git diff'
alias gb='git branch'
alias gl='git log -n 3'
alias gll='git log --oneline -n 10'
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

# SCP & download RENAV legacy csv
alias renavscp='scp root@146.190.148.249:/var/www/vhosts/renav.com/httpdocs/mls/grid/data/property_missingDbColumns.csv /home/aaron/property_missingDbColumns.csv'
