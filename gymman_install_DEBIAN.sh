#!/usr/bin/env bash
set -e

echo "==========================================="
echo " GymMan Demo: MariaDB + Python Venv Setup  "
echo "==========================================="

# === CONFIG ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$SCRIPT_DIR/gymman-demo"
VENV_DIR="$APP_DIR/venv"
SQL_SERVICE="mysql"
SQL_PACKAGES=("mariadb-server" "libmariadb-dev-compat" "python3-venv" "python3-pip")

# === Install Required Packages ===
echo "--------------------------------------"
echo "| Installing MariaDB + Python deps... |"
echo "--------------------------------------"

sudo apt update

for package in "${SQL_PACKAGES[@]}"; do
    if ! dpkg -s "$package" &> /dev/null; then
        echo "Installing $package..."
        sudo apt install -y "$package"
    else
        echo "$package is already installed."
    fi
done

# === Start + Enable MariaDB ===
echo "-------------------------------------------"
echo "| Enabling and starting MariaDB service   |"
echo "-------------------------------------------"

sudo systemctl enable "$SQL_SERVICE"
sudo systemctl start "$SQL_SERVICE"
mysql --version || true

# === Print Manual MariaDB Setup Instructions ===
echo
echo "==============================="
echo " MANUAL MARIADB SETUP REQUIRED"
echo "==============================="
echo
echo "Run the following commands:"
echo
echo "1) Secure MariaDB:"
echo "   sudo mysql_secure_installation"
echo
echo "2) Log into MariaDB as root:"
echo "   sudo mysql"
echo
echo "3) Inside MariaDB, run:"
echo
cat <<'EOF'
CREATE DATABASE gymman;

CREATE USER 'gymman_user'@'localhost'
IDENTIFIED BY 'strong_password_here';

GRANT ALL PRIVILEGES ON gymman.* TO 'gymman_user'@'localhost';
FLUSH PRIVILEGES;

EXIT;
EOF
echo
echo "4) Import the demo database (optional):"
echo "   mysql -u gymman_user -p gymman < scripts/gymman_demo_source.sql"
echo
echo "=========================================================="
echo

# === Create Python Virtual Environment ===
echo "---------------------------------------------"
echo "| Creating Python virtual environment       |"
echo "---------------------------------------------"

cd "$APP_DIR"

if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv venv
    echo "Venv created."
else
    echo "Venv already exists."
fi

# === Activate Venv ===
source venv/bin/activate

# === Install Python Dependencies ===
echo "---------------------------------------------"
echo "| Installing Python packages               |"
echo "---------------------------------------------"

pip install --upgrade pip
pip install flask mysql-connector-python python-dotenv gunicorn

# === Create db.env Template ===
ENV_FILE="$APP_DIR/website/db.env"

if [ ! -f "$ENV_FILE" ]; then
    echo "---------------------------------------------"
    echo "| Creating db.env template                  |"
    echo "---------------------------------------------"

    cat <<EOF > "$ENV_FILE"
DB_HOST=localhost
DB_USER=gymman_user
DB_PASS=CHANGE_ME
DB_NAME=gymman
EOF

    chmod 600 "$ENV_FILE"

    echo "Created db.env (YOU MUST EDIT DB_PASS)."
else
    echo "db.env already exists."
fi

# === Final Instructions ===
echo
echo "===================================="
echo "SYSTEM PACKAGE + VENV SETUP COMPLETE"
echo "===================================="
echo
echo "NEXT STEPS (REQUIRED):"
echo
echo "1) Finish MariaDB setup using the instructions above."
echo
echo "2) Edit your database credentials:"
echo "   nano $APP_DIR/website/db.env"
echo
echo "3) Start the application:"
echo "   cd $APP_DIR"
echo "   source venv/bin/activate"
echo "   python3 main.py"
echo
echo "4) If starting from scratch, you must create an owner account at the very least within users table." 
echo "   This can be done by manualy editing the users table after creating a user from the /gymman-sign-up" 
echo "   page (flip from role_id=3 (member) to role_id=1 (owner))."

