#!/bin/bash
#
# GymMan Installer Script for Debian/Ubuntu
# Installs all dependencies required for wxWidgets + MySQL C++ integration
#
# Usage:
#   chmod +x gymman_install_DEBIAN.sh
#   ./gymman_install_DEBIAN.sh
#

set -e  # Exit immediately on error

echo "-----------------------------------"
echo "| Updating system package lists... |"
echo "-----------------------------------"
sudo apt update

# === Base Required Packages ===
REQUIRED_PACKAGES=(
    "build-essential"          # Compiler and basic dev tools
    "g++"                      # C++ compiler
    "make"                     # Build system
    "libwxgtk3.2-dev"          # wxWidgets (GTK3 version)
    "libmysqlcppconn-dev"      # MySQL C++ Connector
    "libmysqlclient-dev"       # MySQL C client library (dependency)
    "libgl1-mesa-dev"          # OpenGL headers for wxWidgets (if built with OpenGL support)
)

# === Detect MySQL or MariaDB availability ===
MYSQL_CANDIDATE=$(apt-cache policy mysql-server | grep Candidate | awk '{print $2}')

if [ "$MYSQL_CANDIDATE" != "(none)" ]; then
    echo "MySQL server is available in repositories."
    SQL_PACKAGES=("mysql-server")
    SQL_SERVICE="mysql"
else
    echo "Falling back to MariaDB server."
    SQL_PACKAGES=("mariadb-server" "libmariadb-dev-compat")
    SQL_SERVICE="mysql"  # MariaDB service still uses 'mysql'
fi

# Merge arrays
REQUIRED_PACKAGES+=("${SQL_PACKAGES[@]}")

# === Install Missing Packages ===
echo "--------------------------------------"
echo "| Checking and installing packages... |"
echo "--------------------------------------"
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

# === Start and Enable Database Service ===
echo "-------------------------------------------"
echo "| Verifying and starting $SQL_SERVICE service... |"
echo "-------------------------------------------"

mysql --version || true
sudo systemctl enable "$SQL_SERVICE"
sudo systemctl start "$SQL_SERVICE"
sudo systemctl status "$SQL_SERVICE" --no-pager || true

# === Secure the Database Installation ===
echo "---------------------------------------------"
echo "| Running secure installation configuration |"
echo "---------------------------------------------"
if command -v mysql_secure_installation >/dev/null 2>&1; then
    sudo mysql_secure_installation
elif command -v mariadb-secure-installation >/dev/null 2>&1; then
    sudo mariadb-secure-installation
else
    echo "No secure installation script found. You may need to secure the DB manually."
fi

echo "--------------------------------------------------"
echo "| Setup complete! You can now build Gym Manager. |"
echo "--------------------------------------------------"

echo ""
echo "Next steps:"
echo "  1. Build the project:"
echo "       make clean && make"
echo "  2. Run the program:"
echo "       ./gymman"
echo ""