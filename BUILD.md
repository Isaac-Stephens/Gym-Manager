# Main Build Instructions
## Setup Steps
### Prerequisites

Before starting, ensure you are running a **Debian-based Linux distribution** (e.g., Debian, Ubuntu). ***Arch-based distributions*** *are also possible, though they might take more tinkering on your end. I hate myself and run Arch on my desktop so thats why it's sorta compattable.*


---

### 1. Make the installation script executable
```bash
chmod +x gymman_install_DEBIAN.sh
```
### 2. Run the installation script
```bash
./gymman_install_DEBIAN.sh
```
-- OR --
```bash
./gymman_install_ARCH.sh
```

This script will:
- Update the system package lists.
- Install the required dependencies:
  - **MariaDB** (on Debian) or **MySQL** (on Ubuntu)
  - C/C++ database connector libraries (`libmysqlcppconn-dev`, `libmariadb-dev-compat`, or `libmysqlclient-dev` depending on distro)
  - Vulkan dependencies (`libvulkan1`, `mesa-vulkan-drivers`, `vulkan-toos`)
  - GLFW (`libglfw3-dev`)
- Start and enable the database service (`mysql.service` -> actually MariaDB on Debian).
- Run the respective secure installation processes to harden the database.

### 3. Verify database installation
The script will automatically check the MySQL version:
```bash
mysql --version
```
On Debian you will see something like:
```nginx
mysql Ver 15.2 Distrib 11.8.3-MariaDB
```
On Ubuntu you may see:
```rust
mysql Ver 8.0 Distrib for Linux
```

### 4. Manage the database service

The script ensures service starts on boot. You can also manage it manually:

```bash
sudo systemctl start mysql
sudo systemctl stop mysql
sudo systemctl restart mysql
sudo systemctl status mysql
```
*(Even with MariaDB, the service is still called `mysql` for compatibility.)*
### 5. Secure the installation

During the run, the script executes either:
```bash
sudo mysql_secure_installation
```
(for MySQL)

or
```bash
sudo mariadb-secure-installation
```
(for MariaDB)

This step will prompt you to:

- Set the root password
- Remove anonymous users
- Disallow remote root login
- Remove the test database

### 6. Log into the database

Once installed and secured, you can log in with:
```bash
sudo mysql -u root -p
```
*(works for both MySQL and MariaDB since the service is `mysql` for both)*

## Troubleshooting

Depending on if you decide to mannualy install or if you're using the install scripts, you may end up with a few issues (my scripts are ameture at best lol). Here are some I've come upon.

---

### ❌ **Error:** `Package 'mysql-server' has no installation canidate`

This happens on **Debian**, because `mysql-server` is no longer shipped in the default repos and has been replaced by **MariaDB**, which is fully compatible with MySQL.

✅ Fix: Just run the Debian install script (`gymman_install_DEBIAN.sh`). It will automatically install `mariadb-server` instead of `mysql-server`. Or you can do it yourself. I don't care.

---

### ❌ **Error:** `mysql_secure_installation: command not found`

✅ Fix: On Debian, the script is called `mariadb-secure-installation`.

---

### Database not working?

Make sure the service is running *(same for all)*:
```bash
sudo systemctl status mysql
```
Start it manually if needed:
```bash
sudo systemctl start mysql
```

If you changed the root password and forgot it, you can reset it by running MariaDB/MySQL in **skip grant tables** mode *(see the official MySQL/MariaDB docs)*.














