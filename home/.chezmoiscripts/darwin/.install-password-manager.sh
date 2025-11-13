#!/bin/sh

# exit immediately if password-manager-binary is already in $PATH
type op >/dev/null 2>&1 && exit

case "$(uname -s)" in
Darwin)
    # commands to install op on Darwin
    brew install --cask 1password/tap/1password-cli
    ;;
Linux)
    # commands to install op on Linux
    sudo apt-get install 1password-cli
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac
