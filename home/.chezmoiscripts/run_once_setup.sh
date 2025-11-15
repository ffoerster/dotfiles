#!/usr/bin/env bash
# General setup script for all platforms
# Uses bash for portability across macOS, Debian/Ubuntu, and Arch Linux

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

header() {
    echo -e "${BLUE}==>${NC} ${GREEN}$1${NC}"
}

notice() {
    echo -e "${YELLOW}==>${NC} $1"
}

error() {
    echo -e "${RED}Error:${NC} $1" >&2
}

setup_macos() {
    header "Setting up for macOS"

    if ! command -v brew &>/dev/null; then
        notice "Installing Xcode Command Line Tools..."
        sudo xcode-select --install || true
        notice "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    notice "Configuring macOS with sane defaults..."

    # Show hidden files
    defaults write com.apple.Finder AppleShowAllFiles true

    # Do not show recents
    defaults write com.apple.dock "show-recents" -bool "false"

    # Autohide dock
    defaults write com.apple.dock "autohide" -bool "true"

    # Show all file extensions
    defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

    # Don't show files on Desktop
    defaults write com.apple.finder "CreateDesktop" -bool "false"

    killall Finder || true
    killall Dock || true

    header "macOS setup complete"
}

setup_debian() {
    header "Setting up for Debian/Ubuntu"

    # Homebrew on Linux is optional - skip if not wanted
    if ! command -v brew &>/dev/null; then
        notice "Homebrew not installed (optional for Debian/Ubuntu)"
        notice "To install Homebrew on Linux, run:"
        notice "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    fi

    header "Debian/Ubuntu setup complete"
}

setup_arch() {
    header "Setting up for Arch Linux"

    # Arch uses pacman/paru, not Homebrew
    notice "Arch Linux uses pacman and AUR helpers (paru/yay)"
    notice "No additional setup needed"

    header "Arch Linux setup complete"
}

# Create common directories
header "Creating common directories..."
mkdir -p ~/Projects
mkdir -p ~/.local/bin
mkdir -p ~/.config

case "$(uname)" in
    Darwin)
        setup_macos
        ;;
    Linux)
        # Detect Linux distribution
        if [[ -f /etc/os-release ]]; then
            # shellcheck source=/dev/null
            source /etc/os-release
            case "$ID" in
                arch)
                    setup_arch
                    ;;
                debian|ubuntu)
                    setup_debian
                    ;;
                *)
                    notice "Unknown Linux distribution: $ID"
                    notice "Running generic Linux setup"
                    setup_debian
                    ;;
            esac
        else
            error "Cannot detect Linux distribution"
            exit 1
        fi
        ;;
    *)
        error "Unsupported operating system: $(uname)"
        exit 1
        ;;
esac

echo -e "${GREEN}✓${NC} Setup complete!"
