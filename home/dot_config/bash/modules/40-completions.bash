# ============================================================================
# BASH COMPLETIONS
# ============================================================================
# Enable programmable completion features

# ============================================================================
# BASH-COMPLETION PACKAGE
# ============================================================================
# Load bash-completion if installed

# Linux (Arch, Debian, Ubuntu)
if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# macOS (Homebrew)
if [ -f "${BREW_PREFIX}/etc/profile.d/bash_completion.sh" ]; then
    source "${BREW_PREFIX}/etc/profile.d/bash_completion.sh"
fi

# ============================================================================
# CUSTOM COMPLETIONS
# ============================================================================
# Load custom completions from config directory

# Load completions from bash config directory
if [ -d "${BASH_CONFIG_DIR}/completions" ]; then
    for completion_file in "${BASH_CONFIG_DIR}/completions"/*; do
        [[ -f "$completion_file" ]] && source "$completion_file"
    done
    unset completion_file
fi

# ============================================================================
# DOCKER COMPLETIONS
# ============================================================================
# Docker and Docker Compose completions

# Docker completions
if [ -d "$HOME/.docker/completions" ]; then
    for completion_file in "$HOME/.docker/completions"/*.bash; do
        [[ -f "$completion_file" ]] && source "$completion_file"
    done
    unset completion_file
fi

# ============================================================================
# SSH COMPLETIONS
# ============================================================================
# Enable SSH hostname completion from known_hosts

if [ -f "$HOME/.ssh/config" ]; then
    complete -W "$(awk '/^Host / {print $2}' ~/.ssh/config | grep -v '\*')" ssh scp sftp
fi

# ============================================================================
# COMMAND-SPECIFIC COMPLETIONS
# ============================================================================

# Make completions
if command -v make >/dev/null 2>&1; then
    complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile 2>/dev/null | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make
fi

# Git completions (if not already loaded by bash-completion)
if ! command -v __git_complete >/dev/null 2>&1; then
    if [ -f "${BREW_PREFIX}/etc/bash_completion.d/git-completion.bash" ]; then
        source "${BREW_PREFIX}/etc/bash_completion.d/git-completion.bash"
    fi
fi

# NPM/PNPM/Yarn completions
if command -v npm >/dev/null 2>&1; then
    source <(npm completion 2>/dev/null) 2>/dev/null || true
fi

# ============================================================================
# COMPLETION ENHANCEMENTS
# ============================================================================

# Add tab completion for `defaults read|write NSGlobalDomain`
# Could add more macOS-specific completions here if needed
