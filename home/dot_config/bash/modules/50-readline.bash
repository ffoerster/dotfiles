# ============================================================================
# READLINE KEYBINDINGS
# ============================================================================
# Custom key bindings for bash readline

# NOTE: Most readline configuration is in ~/.inputrc
# This file contains bash-specific keybindings that need to be set with `bind`

# ============================================================================
# VI MODE (Optional)
# ============================================================================
# Uncomment to enable vi mode
# set -o vi

# ============================================================================
# EMACS MODE (Default)
# ============================================================================
# Emacs-style keybindings (default)
set -o emacs

# ============================================================================
# HISTORY NAVIGATION
# ============================================================================

# Ctrl+Up/Down for history search based on what you've typed
bind '"\e[1;5A": history-search-backward'
bind '"\e[1;5B": history-search-forward'

# Up/Down arrows for prefix-based history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# ============================================================================
# DIRECTORY NAVIGATION
# ============================================================================

# Alt+Left/Right to move between words
bind '"\e[1;3C": forward-word'
bind '"\e[1;3D": backward-word'

# ============================================================================
# EDITING
# ============================================================================

# Ctrl+Left/Right to delete words
bind '"\e[1;5C": kill-word'
bind '"\e[1;5D": backward-kill-word'

# Ctrl+Delete to delete word forward
bind '"\e[3;5~": kill-word'

# Ctrl+Backspace to delete word backward
bind '"\C-H": backward-kill-word'

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================

# Ctrl+O to open file in editor
bind '"\C-o": "\C-a\C-k $EDITOR \C-m"'

# Ctrl+G to open git status
bind '"\C-g": "\C-a\C-k git status\C-m"'

# ============================================================================
# CONVENIENCE
# ============================================================================

# Make Tab autocomplete regardless of case
bind 'set completion-ignore-case on'

# Display matches for ambiguous patterns immediately
bind 'set show-all-if-ambiguous on'

# Cycle through completions with Tab (menu-complete)
# Uncomment if you prefer cycling behavior
# bind 'TAB: menu-complete'
# bind '"\e[Z": menu-complete-backward'  # Shift+Tab

# ============================================================================
# BELLS
# ============================================================================

# Disable terminal bell
bind 'set bell-style none'
