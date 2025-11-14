# ============================================================================
# LINUX-SPECIFIC CONFIGURATION
# ============================================================================
# Configuration and aliases specific to Linux systems

# ============================================================================
# LINUX-SPECIFIC ALIASES
# ============================================================================

# Package management (automatically detect distro)
if command -v apt >/dev/null 2>&1; then
    # Debian/Ubuntu
    alias update='sudo apt update && sudo apt upgrade -y'
    alias install='sudo apt install'
    alias remove='sudo apt remove'
    alias search='apt search'
    alias autoremove='sudo apt autoremove -y'

elif command -v pacman >/dev/null 2>&1; then
    # Arch Linux
    alias update='sudo pacman -Syu'
    alias install='sudo pacman -S'
    alias remove='sudo pacman -R'
    alias search='pacman -Ss'
    alias clean='sudo pacman -Sc'

    # paru (AUR helper)
    if command -v paru >/dev/null 2>&1; then
        alias aur='paru -S'
        alias aursearch='paru -Ss'
        alias aurupdate='paru -Syu'
    fi

elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    alias update='sudo dnf upgrade'
    alias install='sudo dnf install'
    alias remove='sudo dnf remove'
    alias search='dnf search'

elif command -v zypper >/dev/null 2>&1; then
    # openSUSE
    alias update='sudo zypper update'
    alias install='sudo zypper install'
    alias remove='sudo zypper remove'
    alias search='zypper search'
fi

# System
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias services='systemctl list-units --type=service'
alias ports='sudo netstat -tulanp'

# Display
alias xres='xrdb ~/.Xresources'

# Clipboard (if xclip is available)
if command -v xclip >/dev/null 2>&1; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
elif command -v xsel >/dev/null 2>&1; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

# ============================================================================
# LINUX-SPECIFIC FUNCTIONS
# ============================================================================

# Open file with default application
o() {
    if command -v xdg-open >/dev/null 2>&1; then
        xdg-open "$@" &> /dev/null
    elif command -v gnome-open >/dev/null 2>&1; then
        gnome-open "$@" &> /dev/null
    else
        echo "No file opener found"
        return 1
    fi
}

# Find which package provides a file
whichpkg() {
    if command -v pacman >/dev/null 2>&1; then
        pacman -Qo "$1"
    elif command -v dpkg >/dev/null 2>&1; then
        dpkg -S "$1"
    elif command -v rpm >/dev/null 2>&1; then
        rpm -qf "$1"
    fi
}

# Show system information
sysinfo() {
    echo "=== System Information ==="
    echo "Hostname: $(hostname)"
    echo "Kernel: $(uname -r)"
    echo "Distribution: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '\"')"
    echo "Uptime: $(uptime -p)"
    echo "Memory: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    echo "Disk: $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
}

# ============================================================================
# PATH ADJUSTMENTS
# ============================================================================

# Linuxbrew (if installed)
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Snap binaries
if [ -d "/snap/bin" ]; then
    export PATH="/snap/bin:$PATH"
fi

# Flatpak binaries
if [ -d "/var/lib/flatpak/exports/bin" ]; then
    export PATH="/var/lib/flatpak/exports/bin:$PATH"
fi

# AppImage directory
if [ -d "$HOME/Applications" ]; then
    export PATH="$HOME/Applications:$PATH"
fi

# ============================================================================
# SYSTEMD SHORTCUTS
# ============================================================================

if command -v systemctl >/dev/null 2>&1; then
    alias sc='sudo systemctl'
    alias scs='sudo systemctl status'
    alias scr='sudo systemctl restart'
    alias scu='systemctl --user'
    alias scus='systemctl --user status'
    alias scur='systemctl --user restart'

    # Systemctl functions
    scstart() { sudo systemctl start "$@"; }
    scstop() { sudo systemctl stop "$@"; }
    scenable() { sudo systemctl enable "$@"; }
    scdisable() { sudo systemctl disable "$@"; }
fi

# ============================================================================
# JOURNALCTL SHORTCUTS
# ============================================================================

if command -v journalctl >/dev/null 2>&1; then
    alias jc='journalctl'
    alias jcf='journalctl -f'
    alias jcu='journalctl --user'
    alias jcuf='journalctl --user -f'
fi
