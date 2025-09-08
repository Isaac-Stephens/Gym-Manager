# Main Build Instructions
## Setup Steps
### Prerequisites

Before starting, ensure you are running a **Debian-based Linux distribution** (e.g., Debian, Ubuntu).  
You will also need `sudo` privileges to install packages and configure MySQL.  

---

### 1. Make the installation script executable
```bash
chmod +x gymman_install_DEBIAN.sh
```
### 2. Run the installation script
```bash
./gymman_install_DEBIAN.sh
```
This script will:
- Update the system package lists.
- Install the required dependencies:
- mysql-server (MySQL database server)
- libmysqlclient-dev (MySQL C API headers/libraries)
- libmysqlcppconn-dev (MySQL Connector/C++ for C++ integration)
- Start and enable the MySQL service.
- Run the mysql_secure_installation process to harden the database.

### 3. Verify MySQL installation
The script will automatically check the MySQL version:
```bash
mysql --version
```

### 4. Manage the MySQL service

The script ensures MySQL starts on boot. You can also manage it manually:

```bash
sudo systemctl start mysql
sudo systemctl stop mysql
sudo systemctl restart mysql
sudo systemctl status mysql
```
### 5. Secure MySQL

During the run, the script executes:
```bash
sudo mysql_secure_installation
```

This step will prompt you to:

- Set the root password
- Remove anonymous users
- Disallow remote root login
- Remove the test database

### 6. Log into MySQL

Once installed and secured, you can log in with:
```bash
sudo mysql -u root -p
```
















