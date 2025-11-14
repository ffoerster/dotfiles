# ============================================================================
# ZSH OPTIONS
# ============================================================================
# Configure ZSH behavior

# ============================================================================
# HISTORY
# ============================================================================
setopt EXTENDED_HISTORY          # Save timestamp and duration
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Don't display duplicates when searching
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicates to history file
setopt HIST_VERIFY               # Show command with history expansion before running
setopt INC_APPEND_HISTORY        # Append to history immediately
setopt SHARE_HISTORY             # Share history between sessions

# ============================================================================
# COMPLETION
# ============================================================================
setopt ALWAYS_TO_END             # Move cursor to end of word after completion
setopt AUTO_MENU                 # Show completion menu on successive tab press
setopt COMPLETE_IN_WORD          # Complete from both ends of a word
setopt MENU_COMPLETE             # Insert first match immediately
set opt AUTO_LIST                # Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH          # Add trailing slash for completed directories

# ============================================================================
# DIRECTORY NAVIGATION
# ============================================================================
setopt AUTO_CD                   # Change directory without cd command
setopt AUTO_PUSHD                # Make cd push old directory onto stack
setopt PUSHD_IGNORE_DUPS         # Don't push multiple copies of same directory
setopt PUSHD_SILENT              # Don't print directory stack after pushd/popd
setopt PUSHD_TO_HOME             # pushd with no arguments goes to home
setopt CDABLE_VARS               # Change to a path in a variable

# ============================================================================
# GLOBBING
# ============================================================================
setopt EXTENDED_GLOB             # Use extended globbing syntax
setopt GLOB_DOTS                 # Include dotfiles in globbing
setopt NO_CASE_GLOB              # Case-insensitive globbing
setopt NUMERIC_GLOB_SORT         # Sort numerical filenames numerically

# ============================================================================
# CORRECTION
# ============================================================================
setopt CORRECT                   # Try to correct spelling of commands
setopt CORRECT_ALL               # Try to correct spelling of all arguments

# ============================================================================
# JOB CONTROL
# ============================================================================
setopt AUTO_RESUME               # Resume existing job instead of creating new one
setopt LONG_LIST_JOBS            # List jobs in long format by default
setopt NOTIFY                    # Report status of background jobs immediately

# ============================================================================
# MISC
# ============================================================================
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive shell
setopt MULTIOS                   # Enable multiple redirections
setopt PROMPT_SUBST              # Enable parameter expansion in prompt
setopt RC_QUOTES                 # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
