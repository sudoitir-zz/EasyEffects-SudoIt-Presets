#!/usr/bin/env bash

GIT_REPOSITORY="https://raw.githubusercontent.com/sudoitir/PulseEffects-SudoIt-Presets/master"

check_install() {
  if command -v flatpak &>/dev/null && flatpak list | grep -q "com.github.wwmm.easyeffects"; then
    PRESETS_DIRECTORY="$HOME/.var/app/com.github.wwmm.easyeffects/config/easyeffects"
  elif which easyeffects >/dev/null; then
    PRESETS_DIRECTORY="$HOME/.config/easyeffects"
  else
    echo "Error! Couldn't find EasyEffects presets directory!"
    exit 1
  fi
  mkdir -p "$PRESETS_DIRECTORY"
}

check_impulse_response_directory() {
  if [ ! -d "$PRESETS_DIRECTORY/irs" ]; then
    mkdir "$PRESETS_DIRECTORY/irs"
  fi
}

read_choice() {
  CHOICE=""
  while [[ ! $CHOICE =~ ^[1-5]+$ ]]; do
    read -r CHOICE
    if [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt 5 ]; then
      echo "Invalid option! Please input a value between 1 and 5!"
    fi
  done
}

install_menu() {
  echo "Press 1 to continue"
  echo "1) Install Sudoit preset"
}

install_preset() {
  case $CHOICE in
  1)
    echo "Installing Sudoit preset..."
    curl "$GIT_REPOSITORY/impulse/Razor Surround.irs" --output "$PRESETS_DIRECTORY/impulse/Razor Surround.irs" --silent
    curl "https://raw.githubusercontent.com/sudoitir/PulseEffects-SudoIt-Presets/master/SudoitEQ.json" --output "$PRESETS_DIRECTORY/output/SudoitEQ.json" --silent
    ;;

  esac

}

check_install
check_impulse_response_directory
install_menu
read_choice
install_preset
