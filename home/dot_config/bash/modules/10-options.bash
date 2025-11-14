# ============================================================================
# BASH OPTIONS
# ============================================================================
# Bash shell options and behavior configuration

# ============================================================================
# SHELL OPTIONS (shopt)
# ============================================================================

# Append to history file, don't overwrite it
shopt -s histappend

# Save multi-line commands in history as single line
shopt -s cmdhist

# Check window size after each command and update LINES and COLUMNS
shopt -s checkwinsize

# Enable extended pattern matching
shopt -s extglob

# Enable ** for recursive glob patterns
shopt -s globstar

# Case-insensitive pathname expansion
shopt -s nocaseglob

# Include dotfiles in pathname expansion
shopt -s dotglob

# Spell check directory names during tab completion
shopt -s dirspell

# Spell check commands during command completion
shopt -s cdspell

# Correct minor errors in the spelling of a directory name in cd command
shopt -s cdable_vars

# Execute a directory name as if it were a cd command
shopt -s autocd 2>/dev/null || true  # Bash 4+ only

# ============================================================================
# HISTORY CONFIGURATION
# ============================================================================

# Don't add duplicate commands to history
# Don't add commands starting with space to history
export HISTCONTROL=ignoreboth:erasedups

# Ignore common commands in history
export HISTIGNORE="ls:ll:la:cd:pwd:exit:clear:history"

# Add timestamp to history
export HISTTIMEFORMAT="%F %T "

# Increase history size (already set in 00-env.bash but repeated for clarity)
export HISTSIZE=50000
export HISTFILESIZE=50000

# Save history immediately after each command
PROMPT_COMMAND="history -a;${PROMPT_COMMAND}"

# ============================================================================
# COMPLETION OPTIONS
# ============================================================================

# Enable case-insensitive completion
bind 'set completion-ignore-case on'

# Treat hyphens and underscores as equivalent in completion
bind 'set completion-map-case on'

# Display matches for ambiguous patterns at first tab press
bind 'set show-all-if-ambiguous on'

# Immediately add a trailing slash when completing symlinks to directories
bind 'set mark-symlinked-directories on'

# Color completion matches
bind 'set colored-stats on'

# Show file type indicators in completion
bind 'set visible-stats on'

# Enable menu-complete behavior (cycle through completions)
bind 'set menu-complete-display-prefix on'

# ============================================================================
# INPUT/OUTPUT
# ============================================================================

# Enable programmable completion
shopt -s progcomp

# Don't use ^D to exit the shell
set -o ignoreeof

# ============================================================================
# JOB CONTROL
# ============================================================================

# Enable job control
set -m

# Notify when background job finishes
set -b
