# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================
# Useful shell functions for productivity

# ============================================================================
# FILE & DIRECTORY OPERATIONS
# ============================================================================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract archives of various types
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find file by name (case-insensitive)
ff() {
    find . -iname "*$1*" 2>/dev/null
}

# Find directory by name (case-insensitive)
# Note: Named fdir() to avoid conflict with fd-find binary
fdir() {
    find . -type d -iname "*$1*" 2>/dev/null
}

# ============================================================================
# GIT FUNCTIONS
# ============================================================================

# Git add all and commit
gac() {
    git add --all && git commit -m "$*"
}

# Git add all, commit, and push
gacp() {
    git add --all && git commit -m "$*" && git push
}

# Create new git branch and check it out
gnb() {
    git checkout -b "$1"
}

# Git log with graph
glog() {
    git log --graph --pretty=format:'%C(yellow)%h%Creset %C(blue)%an%Creset %C(green)%ar%Creset - %s' --abbrev-commit
}

# Show git branch stats
gbstats() {
    git for-each-ref --sort=-committerdate --format='%(committerdate:short) %(refname:short)' refs/heads/
}

# ============================================================================
# NETWORK FUNCTIONS
# ============================================================================

# Get public IP with details
myipinfo() {
    curl -s https://ipinfo.io/ | jq '.'
}

# Test website response time
webtest() {
    curl -o /dev/null -s -w "Connect: %{time_connect}s\nStart Transfer: %{time_starttransfer}s\nTotal: %{time_total}s\n" "$1"
}

# Find process using a port
port() {
    lsof -i ":$1" 2>/dev/null || netstat -tulanp 2>/dev/null | grep ":$1"
}

# ============================================================================
# SEARCH FUNCTIONS
# ============================================================================

# Search in file contents (recursive)
search() {
    if command -v rg >/dev/null 2>&1; then
        rg "$1"
    else
        grep -r "$1" .
    fi
}

# Search in history
hs() {
    history | grep "$1"
}

# ============================================================================
# SYSTEM FUNCTIONS
# ============================================================================

# Get system information
sysinfo() {
    if command -v fastfetch >/dev/null 2>&1; then
        fastfetch
    elif command -v neofetch >/dev/null 2>&1; then
        neofetch
    else
        echo "System: $(uname -s)"
        echo "Host: $(hostname)"
        echo "Kernel: $(uname -r)"
        echo "Shell: $SHELL"
    fi
}

# Display disk usage in current directory
duh() {
    du -h --max-depth=1 2>/dev/null | sort -hr
}

# Find largest files in current directory
largest() {
    find . -type f -exec ls -lh {} \; 2>/dev/null | sort -k5 -hr | head -n ${1:-10}
}

# ============================================================================
# DEVELOPMENT FUNCTIONS
# ============================================================================

# Create and activate Python virtual environment
venv() {
    python3 -m venv venv && source venv/bin/activate
}

# Serve current directory with Python HTTP server
serve() {
    local port="${1:-8000}"
    python3 -m http.server "$port"
}

# Quick JSON formatting
jsonformat() {
    if [ -f "$1" ]; then
        cat "$1" | jq '.'
    else
        echo "$1" | jq '.'
    fi
}

# ============================================================================
# DOCKER FUNCTIONS
# ============================================================================

# Docker cleanup - remove stopped containers and unused images
dcleanup() {
    echo "Removing stopped containers..."
    docker container prune -f
    echo "Removing unused images..."
    docker image prune -f
    echo "Removing unused volumes..."
    docker volume prune -f
    echo "Removing unused networks..."
    docker network prune -f
}

# Docker shell into container
dsh() {
    docker exec -it "$1" /bin/bash || docker exec -it "$1" /bin/sh
}

# Docker logs follow
dlf() {
    docker logs -f "$1"
}

# ============================================================================
# TEXT PROCESSING
# ============================================================================

# Convert to lowercase
lower() {
    echo "$*" | tr '[:upper:]' '[:lower:]'
}

# Convert to uppercase
upper() {
    echo "$*" | tr '[:lower:]' '[:upper:]'
}

# Generate random password
genpass() {
    local length="${1:-16}"
    openssl rand -base64 48 | cut -c1-"$length"
}

# ============================================================================
# QUICK NOTES
# ============================================================================

# Quick note taking
note() {
    local notes_file="${HOME}/.notes/$(date +%Y-%m-%d).md"
    mkdir -p "$(dirname "$notes_file")"

    if [ $# -eq 0 ]; then
        ${EDITOR} "$notes_file"
    else
        echo "$(date +%H:%M) - $*" >> "$notes_file"
    fi
}

# ============================================================================
# MISC UTILITIES
# ============================================================================

# Calculator
calc() {
    python3 -c "print($*)"
}

# Weather
weather() {
    local location="${1:-}"
    curl -s "wttr.in/${location}?format=3"
}

# Detailed weather
weatherfull() {
    local location="${1:-}"
    curl -s "wttr.in/${location}"
}

# Cheat sheet
cheat() {
    curl -s "cheat.sh/$1"
}

# Backup file with timestamp
backup() {
    local file="$1"
    cp "$file" "${file}.backup.$(date +%Y%m%d_%H%M%S)"
}

# Create temporary directory and cd into it
tmpdir() {
    local tmp=$(mktemp -d)
    cd "$tmp"
    echo "Created temporary directory: $tmp"
}
