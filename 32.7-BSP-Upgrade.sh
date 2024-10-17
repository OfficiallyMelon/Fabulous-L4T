#!/bin/bash

# Script put together from commands from l4t discord (from theofficialgman)

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root using sudo"
  exit
fi

echo "Upgrading BSP!"

echo "Updating all installed packages..."
sudo apt update && sudo apt dist-upgrade -y

echo "Adding noble-32-7 distribution support..."
echo "deb [signed-by=/etc/apt/keyrings/theofficialgman-L4T.asc] https://theofficialgman.github.io/l4t-debs/ l4t noble-32-7" | sudo tee /etc/apt/sources.list.d/theofficialgman-L4T-32-7.list

echo "Removing BSP version restrictions..."
sudo rm -f /etc/apt/preferences.d/00-switch-bsp-restrictions

echo "Updating package list and installing nvidia-bsp-32-7..."
sudo apt update
sudo apt install -y -o Dpkg::Options::="--force-confdef" nvidia-bsp-32-7

echo "Installed BSP 32.7!"
