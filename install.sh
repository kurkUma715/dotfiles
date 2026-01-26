#!/bin/bash

set -e

PACKAGES="git bspwm sxhkd polybar rofi xorg-xinit xorg-server xclip ttf-hack ttf-jetbrains-mono-nerd alacritty fish firefox telegram-desktop ranger feh picom dunst breeze-icons breeze gtk3 gtk4"
CFG_PATH="$PWD/config"
DEST_PATH="$HOME/.config"
PACKAGE_MANAGER="pacman"
PACKAGE_MANAGER_ARGS="-Syu"

install_custom_packages() {
  git clone https://github.com/kurkUma715/wrapperctl
  cd wrapperctl
  make install
  wrapperctl install -s -si -a pacman brumba
  cd ..
}

echo "COPYING CONFIGS..."
mkdir -p "$DEST_PATH"
for dir in "$CFG_PATH"/*; do
  if [ -d "$dir" ]; then
    cp -r "$dir" "$DEST_PATH"
  fi
done

cp -r "$PWD/Wallpapers" "$HOME/"
cp "$PWD/xinitrc" "$HOME/.xinitrc"
cp "$PWD/Xresources" "$HOME/.Xresources"

echo "INSTALLING PACKAGES..."
sudo $PACKAGE_MANAGER $PACKAGE_MANAGER_ARGS $PACKAGES

echo "INSTALLING CUSTOM PACKAGES..."
install_custom_packages
