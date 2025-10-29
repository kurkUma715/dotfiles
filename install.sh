#!/bin/bash

# --- Цвета для вывода ---
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# --- Проверка на root ---
if [ "$EUID" -eq 0 ]; then
  echo -e "${RED}Не запускай от root. Используй обычного пользователя с sudo.${RESET}"
  exit 1
fi

echo -e "${YELLOW}==> Установка необходимых пакетов...${RESET}"

# --- Установка пакетов ---
sudo pacman -Syu --needed --noconfirm \
  bspwm sxhkd polybar rofi xorg-xinit xorg-server ttf-jetbrains-mono-nerd

if [ $? -ne 0 ]; then
  echo -e "${RED}Ошибка при установке пакетов.${RESET}"
  exit 1
fi

echo -e "${GREEN}Пакеты успешно установлены.${RESET}"

# --- Пути ---
SRC_DIR="$(pwd)/configs"
DEST_DIR="$HOME/.config"

# --- Проверка наличия configs ---
if [ ! -d "$SRC_DIR" ]; then
  echo -e "${RED}Папка configs не найдена. Запусти скрипт из корня проекта, где есть папка configs.${RESET}"
  exit 1
fi

# --- Копирование конфигов ---
echo -e "${YELLOW}==> Копирование конфигов в ~/.config...${RESET}"

mkdir -p "$DEST_DIR"

for dir in bspwm sxhkd polybar rofi; do
  if [ -d "$SRC_DIR/$dir" ]; then
    mkdir -p "$DEST_DIR/$dir"
    cp -r "$SRC_DIR/$dir"/* "$DEST_DIR/$dir/"
    echo -e "${GREEN}✔ $dir скопирован.${RESET}"
  else
    echo -e "${YELLOW}⚠ Папка $dir не найдена в configs.${RESET}"
  fi
done

# --- Копирование xinitrc и Xresources ---
if [ -f "$SRC_DIR/xinitrc" ]; then
  cp "$SRC_DIR/xinitrc" "$HOME/.xinitrc"
  echo -e "${GREEN}✔ xinitrc → ~/.xinitrc${RESET}"
else
  echo -e "${YELLOW}⚠ xinitrc не найден.${RESET}"
fi

if [ -f "$SRC_DIR/Xresources" ]; then
  cp "$SRC_DIR/Xresources" "$HOME/.Xresources"
  echo -e "${GREEN}✔ Xresources → ~/.Xresources${RESET}"
else
  echo -e "${YELLOW}⚠ Xresources не найден.${RESET}"
fi

# --- Права на скрипты bspwm и sxhkd ---
chmod +x "$DEST_DIR/bspwm/"* 2>/dev/null
chmod +x "$DEST_DIR/sxhkd/"* 2>/dev/null

echo -e "${GREEN}==> Установка завершена успешно!${RESET}"
echo -e "${YELLOW}Теперь можешь запустить: startx${RESET}"
