#!/bin/bash

printf "\033[1m\033[7mUpdating Fedora\033[0m"
printf "\n"
sudo dnf update -y --refresh --allowerasing

printf "\033[1m\033[7mUpdating Flatpak\033[0m"
printf "\n"
flatpak update -y

printf "\033[1m\033[7mUpdate completed\033[0m"