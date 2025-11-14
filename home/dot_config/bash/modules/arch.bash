# ============================================================================
# ARCH LINUX SPECIFIC CONFIGURATION
# ============================================================================
# Arch Linux-specific aliases, functions, and environment variables

# ============================================================================
# PACMAN ALIASES
# ============================================================================
# Additional Arch-specific package management aliases
# (Note: Basic pacman aliases are already in 20-aliases.bash)

# Pacman with sudo
alias pacupg='sudo pacman -Syu'          # Upgrade packages
alias pacin='sudo pacman -S'             # Install package
alias pacrem='sudo pacman -Rns'          # Remove package with dependencies
alias pacinfo='pacman -Si'               # Get info about package from repo
alias paclocal='pacman -Qi'              # Get info about installed package
alias pacsearch='pacman -Ss'             # Search for package
alias pacclean='sudo pacman -Scc'        # Clean package cache
alias pacorphans='sudo pacman -Rns $(pacman -Qtdq)' # Remove orphaned packages

# Paru (AUR helper) shortcuts
if command -v paru >/dev/null 2>&1; then
    alias paruin='paru -S'               # Install AUR package
    alias paruupg='paru -Syu'            # Upgrade all packages (including AUR)
    alias parusearch='paru -Ss'          # Search AUR
fi

# Yay (alternative AUR helper) shortcuts
if command -v yay >/dev/null 2>&1; then
    alias yayin='yay -S'                 # Install AUR package
    alias yayupg='yay -Syu'              # Upgrade all packages (including AUR)
    alias yaysearch='yay -Ss'            # Search AUR
fi

# ============================================================================
# ARCH SYSTEM FUNCTIONS
# ============================================================================

# List recently installed packages
alias paclast='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort | tail -20'

# List largest packages
alias pacbig='expac -H M "%m\t%n" | sort -h | tail -20'

# List explicitly installed packages
alias pacexplicit='pacman -Qe'

# Find which package owns a file
pacown() {
    if [ -z "$1" ]; then
        echo "Usage: pacown <file>"
        return 1
    fi
    pacman -Qo "$1"
}

# Search for installed packages by description
pacdesc() {
    if [ -z "$1" ]; then
        echo "Usage: pacdesc <search_term>"
        return 1
    fi
    pacman -Qs "$1"
}

# ============================================================================
# ARCH BUILD SYSTEM (ABS)
# ============================================================================

# Make package from PKGBUILD
alias makepkg='makepkg -si'              # Build and install package

# ============================================================================
# SYSTEMD SHORTCUTS
# ============================================================================

# Systemctl shortcuts
alias sysstart='sudo systemctl start'
alias sysstop='sudo systemctl stop'
alias sysrestart='sudo systemctl restart'
alias sysstatus='systemctl status'
alias sysenable='sudo systemctl enable'
alias sysdisable='sudo systemctl disable'
alias syslist='systemctl list-units --type=service'
alias sysfailed='systemctl --failed'

# User systemctl shortcuts
alias usysstart='systemctl --user start'
alias usysstop='systemctl --user stop'
alias usysrestart='systemctl --user restart'
alias usysstatus='systemctl --user status'
alias usysenable='systemctl --user enable'
alias usysdisable='systemctl --user disable'

# ============================================================================
# JOURNALCTL SHORTCUTS
# ============================================================================

alias jctl='journalctl'
alias jctlf='journalctl -f'              # Follow journal
alias jctlb='journalctl -b'              # This boot
alias jctlp='journalctl -p'              # Priority
alias jctlu='journalctl -u'              # By unit

# ============================================================================
# ARCH-SPECIFIC ENVIRONMENT
# ============================================================================

# Makepkg configuration
export MAKEFLAGS="-j$(nproc)"            # Use all cores for building

# ============================================================================
# ARCH UTILITIES
# ============================================================================

# Check for .pacnew and .pacsave files
alias pacnew='sudo find /etc -name "*.pacnew"'
alias pacsave='sudo find /etc -name "*.pacsave"'

# Show mirror list status
alias mirrorlist='cat /etc/pacman.d/mirrorlist'

# Refresh pacman mirrors (requires reflector)
if command -v reflector >/dev/null 2>&1; then
    alias mirrorsync='sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
fi
