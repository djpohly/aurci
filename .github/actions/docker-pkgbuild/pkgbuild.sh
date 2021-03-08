#!/bin/bash

set -ex

# Environment variables.
export PACKAGER="https://travis-ci.org/${1}/builds/${3}"

# Variables declaration.
declare -r pkgslug="$1"
declare -r pkgtag="$2"
declare -r pkgrepo="${1#*/}"
declare SIGN_PKG=

# Set up gpg options
mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"
echo 'auto-key-retrieve:0:1' | gpgconf --change-options gpg
echo 'keyserver:0:"hkp%3a//na.pool.sks-keyservers.net' | gpgconf --change-options dirmngr
gpgconf --reload all
# HACK: auto-key-retrieve doesn't currently retrieve based on keyid alone
gpg --recv-key $(source PKGBUILD && echo "${validpgpkeys[@]}")
if [[ -r master/signing.key ]]; then
  gpg --import master/signing.key
  gpg --export --armor | sudo tee /usr/share/pacman/keyrings/pkgbuild.gpg >/dev/null
  gpg -k --with-colons | grep -m1 '^fpr' | cut -d: -f10 | sed 's/$/:4:/' | sudo tee /usr/share/pacman/keyrings/pkgbuild-trusted >/dev/null
  sudo rm -rf /etc/pacman.d/gnupg
  sudo pacman-key --init
  sudo pacman-key --populate archlinux pkgbuild
  SIGN_PKG=--sign
fi

# Enable multilib repository.
sudo sed -i -e "/\[multilib\]/,/Include/s/^#//" "/etc/pacman.conf"

# Add configuration for repository.
cat - /etc/pacman.conf > /tmp/pacman.conf.new << EOF
[${pkgrepo}]
SigLevel = Optional TrustAll
Server = https://github.com/${pkgslug}/releases/download/${pkgtag}
EOF
sudo cp /tmp/pacman.conf.new /etc/pacman.conf

# Sync repositories
sudo pacman -Sy

export PKGDEST=repo LC_MESSAGES=C LANG=C

# Build and sign packages
makepkg -Lcs --noconfirm $SIGN_PKG

# Build repo update
makepkg --packagelist | while read -r filename; do
	newfname=${filename//:/.}
	mv -n "$filename" "$newfname"
	mv -n "$filename.sig" "$newfname.sig"
	repo-add master/pkgbuild.db.tar "$newfname"
done

{ set +ex; } 2>/dev/null
