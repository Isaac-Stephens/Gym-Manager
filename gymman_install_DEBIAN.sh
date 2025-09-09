#!/bin/bash

# This script will install all the necessary dependencies
# and build run the neccecary build steps for DEBIAN based
# linux distrubutions.

# $ chmod +x gymman_install_DEBIAN.sh
# $ ./gymman_install_DEBIAN.sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Update package lists
echo "-----------------------------"
echo "| Updating package lists... |"
echo "-----------------------------"
sudo apt update

# Define an array of required packages
REQUIRED_PACKAGES=("mysql-server" "libmysqlclient-dev" "mysql-server" "libmysqlcppconn-dev" "libvulkan1" "mesa-vulkan-drivers" "vulkan-tools" "libglfw3-dev")

# Loop through the packages and install them if not already installed
echo "Checking and installing required packages..."
for package in "${REQUIRED_PACKAGES[@]}"; do
    if ! dpkg -s "$package" &> /dev/null; then
        echo "Installing $package..."
        sudo apt install -y "$package"
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

sudo systemctl start mysql
sudo systemctl enable mysql

sudo systemctl status mysql

# Set a root password, remove anonomous users, disallow remote root login, remove test databases
sudo mysql_secure_installation

# login to MySQL:
# $ sudo mysql -u root -p