#!/bin/bash

# This script will install all the necessary dependencies
# and build run the necessary build steps for DEBIAN based
# linux distributions.

# $ chmod +x gymman_install_DEBIAN.sh
# $ ./gymman_install_DEBIAN.sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Update package lists
echo "-----------------------------"
echo "| Updating package lists... |"
echo "-----------------------------"
sudo apt update

# Base required packages
REQUIRED_PACKAGES=("libmysqlcppconn-dev" "libvulkan1" "mesa-vulkan-drivers" "vulkan-tools" "libglfw3-dev")

# Handle MySQL vs MariaDB
MYSQL_CANDIDATE=$(apt-cache policy mysql-server | grep Candidate | awk '{print $2}')

if [ "$MYSQL_CANDIDATE" != "(none)" ]; then
    echo "MySQL server is available in repos."
    SQL_PACKAGES=("mysql-server" "libmysqlclient-dev")
    SQL_SERVICE="mysql"
else
    echo "Falling back to MariaDB server."
    SQL_PACKAGES=("mariadb-server" "libmariadb-dev-compat")
    SQL_SERVICE="mysql"   # MariaDB service is still called 'mysql'
fi

# Merge arrays
REQUIRED_PACKAGES+=("${SQL_PACKAGES[@]}")

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
echo "| Verifying and starting $SQL_SERVICE service... |"
echo "-------------------------------------------"

mysql --version || true

sudo systemctl start "$SQL_SERVICE"
sudo systemctl enable "$SQL_SERVICE"
sudo systemctl status "$SQL_SERVICE" --no-pager

# Set a root password, remove anonymous users, disallow remote root login, remove test databases
if sudo mysql_secure_installationif command -v mysql_secure_installation >/dev/null 2>&1; then
    sudo mysql_secure_installation
elif command -v mariadb-secure-installation >/dev/null 2>&1; then
    sudo mariadb-secure-installation
else
    echo "No secure installation script found. You may need to secure MariaDB manually."
fi

# login to MySQL:
# $ sudo mysql -u root -p