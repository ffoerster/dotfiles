#!/usr/bin/env bash

if type -P 1password &>/dev/null; then
  echo "1Password is already installed. Skipping"
  exit 0
fi

if type -P apt &>/dev/null; then
  echo "Installing 1Password on Ubuntu/Debian..."
  # Add the key for the 1Password apt repository
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
  # Add the 1Password apt repository
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
  # Add the debsig-verify policy
  sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
  curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
  sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
  # Update package list and install 1Password
  sudo apt update
  sudo apt install -y 1password
# Arch Linux-based
elif type -P pacman &>/dev/null; then
  echo "Installing 1Password on Arch Linux..."
  # Note: This requires yay or another AUR helper
  if type -P yay &>/dev/null; then
    yay -S --noconfirm 1password
  else
    echo "Please install yay or another AUR helper first, then run: yay -S 1password"
    exit 1
  fi
else
  echo "Unsupported Linux distribution"
  echo "Please visit https://1password.com/downloads/linux/ for manual installation instructions"
  exit 1
fi
