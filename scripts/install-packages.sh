#!/bin/bash

# validate root rights
if [ "$(id -u)" -ne 0 ]; then
    echo "✗ This script must be run as root!"
    exit 1
fi

# variables
log_file=~/install-packages-log-$(date +%Y%m%d-%H%M%S).txt
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# helper functions
log() {
    echo -e $1 >> $log_file
}

log_success() {
    log "${GREEN}✓${NC} $1"
}

log_fail() {
    log "${RED}✗${NC} $1"
}

log_info() {
    log "${BLUE}ℹ${NC} $1"
}

apt-install() {
    if type -p $1 > /dev/null; then
        echo "Already installed: $1"
        read -p "Want to attempt to update package ${1}? (y/n) [y]: " CHOICE
        CHOICE=${CHOICE:-y}
        if [[ "$CHOICE" =~ ^[Yy]$ ]]; then
            echo "Updating..."
            apt install --only-upgrade $1
            log_info "Updated: $1"
        else
            echo "Update Skipped"
            log_info "Skipped update: $1"
        fi
    else
        apt -y install ${1}
        if type -p $1 > /dev/null; then
            log_success "Successful installed: $1"
        else
            log_fail "Failed to install: $1"
        fi
    fi
}

# install common-packages
echo -e "${CYAN}Installing common-packages${NC}"
apt-install "git"
apt-install "vim"
apt-install "tmux"

# install packages for tmux theme (emang7/simple-dev-tmux)
echo -e "${CYAN}Installing requirements for \"emang7/simple-dev-tmux\"${NC}"
apt-install "bc"
apt-install "jq"
apt-install "gh"

# clone tpm github repo
echo "Cloing git repo for tmux plugin manager (tpm)"
if [ ! -e ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null
    if [ -e ~/.tmux/plugins/tpm ]; then
        log_success "Successful installed: tpm"
    else
        log_fail "Failed to install: tpm"
    fi
else
    log_info "Found: tpm"
fi

# summary
clear
echo -e "\n══════ Summary ══════\n"
cat $log_file
echo ""
rm $log_file
