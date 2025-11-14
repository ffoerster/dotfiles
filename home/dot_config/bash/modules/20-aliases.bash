# ============================================================================
# ALIASES
# ============================================================================
# Command shortcuts and replacements

# ============================================================================
# BASIC TOOLS
# ============================================================================
alias x="exit"
alias c="clear"
alias h="history"
alias zshconfig="${EDITOR} ${ZDOTDIR}/.zshrc"

# ============================================================================
# MODERN CLI REPLACEMENTS
# ============================================================================
# Use modern tools when available

# bat > cat
if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
    alias ccat='cat'  # Original cat if needed
fi

# eza > ls
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons=auto'
    alias ll='eza -l --icons=auto --git'
    alias la='eza -la --icons=auto --git'
    alias lt='eza --tree --level=2 --icons=auto'
    alias lta='eza --tree --level=2 --icons=auto -a'
# lsd > ls (fallback)
elif command -v lsd >/dev/null 2>&1; then
    alias ls='lsd'
    alias ll='lsd -l'
    alias la='lsd -la'
    alias lt='lsd --tree --depth=2'
# Regular ls with colors
else
    alias ls='ls --color=auto'
    alias ll='ls -lh'
    alias la='ls -lAh'
fi

# ripgrep > grep
if command -v rg >/dev/null 2>&1; then
    alias grep='rg'
fi

# fd > find
if command -v fd >/dev/null 2>&1; then
    alias find='fd'
fi

# bottom/btop > top
if command -v btop >/dev/null 2>&1; then
    alias top='btop'
elif command -v bottom >/dev/null 2>&1; then
    alias top='btm'
fi

# duf > df
if command -v duf >/dev/null 2>&1; then
    alias df='duf'
fi

# dust > du
if command -v dust >/dev/null 2>&1; then
    alias du='dust'
fi

# ============================================================================
# NAVIGATION
# ============================================================================
alias home="cd ~"
alias ..="cd .."
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Quick directory access
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias dev="cd ~/Development"
alias docs="cd ~/Documents"

# ============================================================================
# GIT
# ============================================================================
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline'
alias gll='git log --graph --pretty=format:"%C(yellow)%h%Creset %C(blue)%an%Creset %C(green)%ar%Creset - %s"'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gcl='git clone'
alias gst='git stash'
alias gstp='git stash pop'

# Lazy Git (if installed)
if command -v lazygit >/dev/null 2>&1; then
    alias lg='lazygit'
fi

# ============================================================================
# DOCKER
# ============================================================================
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dcp='docker compose pull'
alias dcu='docker compose up -d --remove-orphans'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'
alias dex='docker exec -it'
alias dprune='docker system prune -af --volumes'

# Lazy Docker (if installed)
if command -v lazydocker >/dev/null 2>&1; then
    alias ld='lazydocker'
fi

# ============================================================================
# SYSTEM INFORMATION
# ============================================================================
alias myip='curl -s https://ipinfo.io/ip'
alias localip='ipconfig getifaddr en0 2>/dev/null || ip route get 1 | awk "{print \$7}"'
alias ports='netstat -tulanp 2>/dev/null || lsof -i -P -n | grep LISTEN'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'

# ============================================================================
# SAFE FILE OPERATIONS
# ============================================================================
alias cp='cp -i'          # Prompt before overwrite
alias mv='mv -i'          # Prompt before overwrite
alias rm='rm -i'          # Prompt before delete
alias mkdir='mkdir -p'    # Create parent directories as needed
alias rmdir='rmdir -p'    # Remove parent directories if empty

# ============================================================================
# PROCESS MANAGEMENT
# ============================================================================
alias psa='ps aux'
alias psg='ps aux | grep'
alias psf='ps aux | fzf'  # Interactive process search (if fzf installed)

# ============================================================================
# TMUX
# ============================================================================
alias ta='tmux attach'
alias tad='tmux attach -d'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
alias tmux_work='tmuxp load ~/.config/tmux/tmuxp-work.yml'

# ============================================================================
# SSH
# ============================================================================
# Force color terminal for SSH connections
alias ssh="TERM=xterm-256color ssh"

# ============================================================================
# NETWORK
# ============================================================================
alias pingg='ping google.com'
alias ping1='ping -c 1'
alias ping5='ping -c 5'

# ============================================================================
# PACKAGE MANAGERS
# ============================================================================
# Homebrew
if command -v brew >/dev/null 2>&1; then
    alias brewup='brew update && brew upgrade && brew cleanup'
    alias brewdeps='brew deps --tree --installed'
fi

# apt (Debian/Ubuntu)
if command -v apt >/dev/null 2>&1; then
    alias aptup='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
    alias apti='sudo apt install'
    alias aptr='sudo apt remove'
    alias apts='apt search'
fi

# pacman (Arch Linux)
if command -v pacman >/dev/null 2>&1; then
    alias pacu='sudo pacman -Syu'
    alias paci='sudo pacman -S'
    alias pacr='sudo pacman -R'
    alias pacs='pacman -Ss'
fi

# paru (AUR helper)
if command -v paru >/dev/null 2>&1; then
    alias paruu='paru -Syu'
    alias parui='paru -S'
fi

# ============================================================================
# CHEZMOI
# ============================================================================
if command -v chezmoi >/dev/null 2>&1; then
    alias cz='chezmoi'
    alias cza='chezmoi apply'
    alias czd='chezmoi diff'
    alias cze='chezmoi edit'
    alias czs='chezmoi status'
    alias czu='chezmoi update'
    alias czcd='chezmoi cd'
fi

# ============================================================================
# DEVELOPMENT
# ============================================================================
alias mypy='python3 -m pytest'

# Node/npm
if command -v npm >/dev/null 2>&1; then
    alias ni='npm install'
    alias nid='npm install --save-dev'
    alias nig='npm install --global'
    alias nr='npm run'
    alias ns='npm start'
    alias nt='npm test'
fi

# pnpm
if command -v pnpm >/dev/null 2>&1; then
    alias pn='pnpm'
    alias pni='pnpm install'
    alias pna='pnpm add'
    alias pnr='pnpm run'
fi

# ============================================================================
# MISC UTILITIES
# ============================================================================
alias reload='exec ${SHELL} -l'  # Reload shell
alias path='echo $PATH | tr ":" "\n"'  # Print PATH line by line
alias week='date +%V'  # Get week number
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
alias update-all='brewup && czupdate && omz update'  # Update everything

# Quick edit common files
alias hosts='sudo ${EDITOR} /etc/hosts'
alias sshconfig='${EDITOR} ~/.ssh/config'
alias gitconfig='${EDITOR} ~/.gitconfig'
