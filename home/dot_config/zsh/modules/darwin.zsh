# ============================================================================
# macOS-SPECIFIC CONFIGURATION
# ============================================================================
# Configuration and aliases specific to macOS

# ============================================================================
# HOMEBREW ENVIRONMENT
# ============================================================================
# Ensure Homebrew is in PATH
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ============================================================================
# macOS-SPECIFIC ALIASES
# ============================================================================

# Finder
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

# Spotlight
alias spotoff='sudo mdutil -a -i off'
alias spoton='sudo mdutil -a -i on'

# System
alias cleanup='sudo periodic daily weekly monthly'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash'
alias hibernate='sudo pmset -a hibernatemode 25'
alias sleep='pmset sleepnow'
alias restart='sudo shutdown -r now'
alias shutdown='sudo shutdown -h now'

# Applications
alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'

# Quick Lock
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Screenshot directory
alias screenshots='cd ~/Desktop'

# ============================================================================
# macOS-SPECIFIC FUNCTIONS
# ============================================================================

# Open current directory in Finder
o() {
    if [ $# -eq 0 ]; then
        open .
    else
        open "$@"
    fi
}

# Change macOS screenshot location
screenshot_location() {
    if [ -n "$1" ]; then
        defaults write com.apple.screencapture location "$1"
        killall SystemUIServer
        echo "Screenshot location changed to: $1"
    else
        echo "Current screenshot location: $(defaults read com.apple.screencapture location)"
    fi
}

# Quick Look
ql() {
    qlmanage -p "$@" &> /dev/null
}

# Create DMG from folder
createdmg() {
    if [ $# -lt 2 ]; then
        echo "Usage: createdmg <folder> <dmg-name>"
        return 1
    fi
    hdiutil create -volname "$2" -srcfolder "$1" -ov -format UDZO "$2.dmg"
}

# ============================================================================
# PATH ADJUSTMENTS
# ============================================================================

# macOS-specific GNU utilities (if installed via Homebrew)
if [ -d "/opt/homebrew/opt/coreutils/libexec/gnubin" ]; then
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
fi

# ============================================================================
# ENVIRONMENT TWEAKS
# ============================================================================

# Disable macOS session restore
export SHELL_SESSION_HISTORY=0

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
