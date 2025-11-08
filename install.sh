#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

if [ "$EUID" -eq 0 ]; then
  echo -e "${RED}Do not run as root. Use a regular user with sudo.${RESET}"
  exit 1
fi

echo -e "${YELLOW}==> Installing required packages...${RESET}"

sudo pacman -Syu --needed --noconfirm \
  bspwm sxhkd polybar rofi xorg-xinit xorg-server ttf-jetbrains-mono-nerd ttf-hack alacritty fish discord firefox telegram-desktop steam ranger feh picom thunar \
  breeze-icons breeze gtk3 gtk4 dunst

if [ $? -ne 0 ]; then
  echo -e "${RED}Package installation failed.${RESET}"
  exit 1
fi

echo -e "${GREEN}Packages installed successfully.${RESET}"

SRC_DIR="$(pwd)/config"
DEST_DIR="$HOME/.config"

if [ ! -d "$SRC_DIR" ]; then
  echo -e "${RED}Config folder not found. Run the script from the project root where the config folder exists.${RESET}"
  exit 1
fi

echo -e "${YELLOW}==> Copying configuration to ~/.config...${RESET}"

mkdir -p "$DEST_DIR"

if [ -d "$SRC_DIR" ]; then
  cp -r "$SRC_DIR"/* "$DEST_DIR/" 2>/dev/null
  echo -e "${GREEN}✔ All configuration copied to ~/.config${RESET}"
  echo -e "${YELLOW}Copied folders:${RESET}"
  for dir in "$SRC_DIR"/*; do
    if [ -d "$dir" ]; then
      dir_name=$(basename "$dir")
      echo -e "${GREEN}  ✔ $dir_name${RESET}"
    fi
  done
else
  echo -e "${RED}Error: config folder not found${RESET}"
  exit 1
fi

if [ -f "$(pwd)/xinitrc" ]; then
  cp "$(pwd)/xinitrc" "$HOME/.xinitrc"
  echo -e "${GREEN}✔ xinitrc → ~/.xinitrc${RESET}"
else
  echo -e "${YELLOW}⚠ xinitrc not found in the project root.${RESET}"
fi

if [ -f "$(pwd)/Xresources" ]; then
  cp "$(pwd)/Xresources" "$HOME/.Xresources"
  echo -e "${GREEN}✔ Xresources → ~/.Xresources${RESET}"
else
  echo -e "${YELLOW}⚠ Xresources not found in the project root.${RESET}"
fi

if [ -d "$(pwd)/Wallpapers" ]; then
  mkdir -p "$HOME/Wallpapers"
  cp -r "$(pwd)/Wallpapers"/* "$HOME/Wallpapers/" 2>/dev/null
  echo -e "${GREEN}✔ Wallpapers copied${RESET}"
else
  echo -e "${YELLOW}⚠ Wallpapers folder not found.${RESET}"
fi

find "$DEST_DIR/bspwm" -type f -exec chmod +x {} \; 2>/dev/null
find "$DEST_DIR/sxhkd" -type f -exec chmod +x {} \; 2>/dev/null
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/scripts/*.sh

alacritty migrate

echo -e "${GREEN}✔ Execution permissions set for bspwm and sxhkd${RESET}"

echo -e "${GREEN}==> Installation completed successfully!${RESET}"
echo -e "${YELLOW}You can now run: startx${RESET}"
