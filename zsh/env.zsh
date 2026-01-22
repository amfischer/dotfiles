# Editor preferences
export EDITOR='nano'
export VISUAL='code'

# Add keychain to PATH
export PATH="$HOME/keychain-2.8.5:$PATH"

# SSH key management
if command -v keychain &> /dev/null && [ -f "$HOME/.ssh/id_ed25519" ]; then
    eval $(keychain --eval --agents ssh --quiet id_ed25519)
fi

# PATH additions
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# export PATH="/usr/local/bin:$PATH"

# Composer global packages
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/home/aaron/.opencode/bin:$PATH

