#!/bin/bash

# This script will install all the necessary dependencies
# and build run the necessary build steps for ARCH based
# linux distributions.

# $ chmod +x gymman_install_DEBIAN.sh
# $ ./gymman_install_DEBIAN.sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Update package lists
echo "-----------------------------"
echo "| Updating package lists... |"
echo "-----------------------------"
sudo pacman -Syu --noconfirm

# Define an array of required packages
REQUIRED_PACKAGES_pacman=("vulkan-icd-loader" "mesa" "vulkan-tools" "glfw")
REQUIRED_PACKAGES_aur=("mysql" "mysql-connector-c++")
# Loop through the packages and install them if not already installed
echo "Checking and installing required packages..."
for package in "${REQUIRED_PACKAGES_pacman[@]}"; do
    if ! pacman -Qi "$package" &> /dev/null; then
        echo "Installing $package..."
        sudo pacman -S  "$package" --noconfirm
    else
        echo "$package is already installed."
    fi
done

if ! command -v yay &> /dev/null; then
    echo "Yay not found. Installing yay..."
    sudo pacman -S --needed git base-devel --noconfirm
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi


for package in "${REQUIRED_PACKAGES_aur[@]}"; do
    if ! yay -Qi "$package" &> /dev/null; then
        echo "Installing $package..."
        sudo yay -S "$package" --noconfirm
    else
        echo "$package is already installed."
    fi
done
echo "--------------------------------------------"
echo "| All required dependencies are installed! |"
echo "--------------------------------------------"

echo "-------------------------------------------"
echo "| Verifying and starting MySQL service... |"
echo "-------------------------------------------"

mysql --version

sudo systemctl start mysqld
sudo systemctl enable mysqld
sudo systemctl status mysqld

# Set a root password, remove anonymous users, disallow remote root login, remove test databases
sudo mysql_secure_installation

# login to MySQL:
# $ sudo mysql -u root -p