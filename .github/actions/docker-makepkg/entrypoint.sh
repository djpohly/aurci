#!/bin/bash

set -ex

# Bootstrap script to be run as root after image is built

# Update packages
pacman -Syu --noconfirm --ignore linux --ignore linux-firmware --needed base-devel

# Ensure wheel group exists (seriously??)
groupadd -f -r wheel

# Create an unprivileged user
useradd -m -G wheel -s /bin/bash pkguser

# Grant group wheel sudo rights without password.
echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

# Run build script as unprivileged user
og=$(stat -c '%u:%g' .)
chown -R pkguser: .
sudo -u pkguser ./.github/actions/docker-makepkg/build.sh "$@"
chown -R "$og" .
