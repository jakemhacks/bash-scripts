#!/bin/bash
# This is a very simple system maintenance/update script
# Author: jakemhacks
# Date: 11/10/2025

echo "===== System Maintainer ====="
# update packages with pacman
echo "Updating system packages..."
sudo pacman -Syu --noconfirm

# update packages from the AUR
echo "Updating AUR packages..."
yay --noconfirm

# pacman does not remove old packages from cache.
# this command removes the all but the last 3 versions of installed packages.
echo "Cleaning package cache (keeping last 3 versions)..."
sudo paccache -r

# this command searches for and removes any dependencies
# that were installed previously and are no longer utilized.
echo "Removing orphaned packages..."
orphans=$(pacman -Qtdq)
if [ -n "$orphans" ]; then
	sudo pacman -Rns $orphans --noconfirm
else
	echo "No orphaned packages found."
fi

echo "Checking for failed systemd services..."
systemctl --failed

echo "Disk Usage:"
df -h / /home

echo "===== Maintenance complete ====="
