#!/bin/bash

printf "\033[1m\033[7mRefreshing the cache\033[0m"

# Refresh the cache
sudo dnf makecache -y --refresh

printf "\033[1m\033[7mUpdating Fedora\033[0m"

# Update Fedora 
sudo dnf update -y --refresh --allowerasing

printf "\033[1m\033[7mUpdating Flatpak\033[0m"

# Update Flatpak
flatpak update -y

printf "\033[1m\033[7mUpdate completed\033[0m"