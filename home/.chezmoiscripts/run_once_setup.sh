#!/usr/bin/env zsh

echo "OK"

setup_macos() {
    echo "Setting up for macOS"

    if ! command -v brew &>/dev/null; then
        sudo xcode-select --install
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "Configuring Mac OS with sane defaults..."

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

    killall Finder
    killall Dock
}

setup_linux() {
    if ! command -v brew &>/dev/null; then
        if [[ -f "/etc/debian_version" ]]; then
            # On Debian, some things must be installed first
            echo "This system is running Debian or a Debian-based distribution."
            sudo apt-get install build-essential procps curl file git
        fi
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

# Create directories
mkdir -p ~/Projects

case "$(uname)" in
    Darwin)
        setup_macos
        ;;
    Linux)
        setup_linux
        ;;
esac
