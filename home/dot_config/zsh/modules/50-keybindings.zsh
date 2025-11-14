# ============================================================================
# KEY BINDINGS
# ============================================================================
# Custom key bindings for ZSH

# ============================================================================
# EMACS VS VI MODE
# ============================================================================
# Use emacs key bindings (change to 'bindkey -v' for vi mode)
bindkey -e

# ============================================================================
# NAVIGATION
# ============================================================================

# Home and End keys
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Alt + arrow keys for word navigation
bindkey '^[[1;3C' forward-word      # Alt + Right
bindkey '^[[1;3D' backward-word     # Alt + Left

# Ctrl + arrow keys (alternative)
bindkey '^[[1;5C' forward-word      # Ctrl + Right
bindkey '^[[1;5D' backward-word     # Ctrl + Left

# ============================================================================
# EDITING
# ============================================================================

# Ctrl + Backspace to delete word backwards
bindkey '^H' backward-kill-word

# Ctrl + Delete to delete word forwards
bindkey '^[[3;5~' kill-word

# Ctrl + U to kill line backwards
bindkey '^U' backward-kill-line

# Ctrl + K to kill line forwards
bindkey '^K' kill-line

# Ctrl + W to delete word backwards (standard)
bindkey '^W' backward-kill-word

# Alt + Backspace to delete word backwards (alternative)
bindkey '^[^?' backward-kill-word

# ============================================================================
# HISTORY
# ============================================================================

# Up/Down arrow for history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Ctrl + R for reverse search (if not using fzf)
bindkey '^R' history-incremental-search-backward

# Ctrl + S for forward search
bindkey '^S' history-incremental-search-forward

# Page Up/Down for history
bindkey '^[[5~' history-beginning-search-backward
bindkey '^[[6~' history-beginning-search-forward

# ============================================================================
# COMPLETION
# ============================================================================

# Shift + Tab for reverse menu completion
bindkey '^[[Z' reverse-menu-complete

# Ctrl + Space to expand aliases
bindkey '^ ' globalias

# ============================================================================
# MISC
# ============================================================================

# Ctrl + X, Ctrl + E to edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Alt + . to insert last argument
bindkey '\e.' insert-last-word

# Ctrl + Q to push current line to buffer and restore after next command
bindkey '^Q' push-line-or-edit

# Delete key
bindkey '^[[3~' delete-char

# ============================================================================
# FZF KEY BINDINGS
# ============================================================================
# These are loaded by fzf itself in 60-tools.zsh
# Ctrl + T - File search
# Ctrl + R - Command history search (overrides default)
# Alt + C - Directory search

# ============================================================================
# CUSTOM WIDGETS
# ============================================================================

# Expand aliases on space
globalias() {
   zle _expand_alias
   zle expand-word
   zle self-insert
}
zle -N globalias

# Quick sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey '^[s' sudo-command-line   # Alt + S
