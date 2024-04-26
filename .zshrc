eval "$(starship init zsh)"

# Set default editor
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Set list aliases
alias ll='ls -l'
alias la='ls -la'

# Set Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gp='git push'
