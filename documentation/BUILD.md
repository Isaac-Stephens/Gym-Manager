# Installation & Local Setup (Debian/Ubuntu)

These instructions assume you are running on a Debian-based Linux system and have cloned this repository from GitHub.

### 1. Clone the Repository
```bash
git clone https://github.com/Isaac-Stephens/Gym-Manager.git
cd Gym-Manager
```

### 2. Run the Dependency & Environment Setup Script

This script will:
- Install MariaDB and required system packages
- Create a Python virtual environment
- Install all required python dependencies
- generate a db.env template for database credentials

```bash
chmod +x gymman_install_DEBIAN.sh
./gymman_install_DEBIAN.sh
```

### 3. Manual MariaDB Setup (REQUIRED)

After the script finishes, you must manually configure MariaDB

#### 3.1 Secure MariaDB
```bash
sudo mysql_secure_installation
```

#### 3.2 Enter MariaDB as Root
```bash
sudo mysql
```

#### 3.3 Create the Database and the User

Inside the MariaDB prompt, run:
```sql
CREATE DATABASE gymman;

CREATE USER 'gymman_user'@'localhost'
IDENTIFIED BY 'strong_password_here';

GRANT ALL PRIVILEGES ON gymman.* TO 'gymman_user'@'localhost';
FLUSH PRIVILEGES;

EXIT;
```
#### 3.4.1 Create the Database Schema
``` bash
mysql -u gymman_user -p gymman < scripts/create_gymman_tables.sql
```

#### 3.4.2 (Optional) Import Demo Database (same database found on isaacstephens.com's demo)
```bash
mysql -u gymman_user -p gymman < scripts/gymman_demo_source.sql
```

### 4. Configure Database Credentials

Edit the environment file created by the script:
```bash
nano gymman-demo/db.env
```

### 5. Start the Application
```bash
cd gymman-demo
source venv/bin/activate
python3 main.py
```

The server will start at: `http://127.0.0.1:5000`

### 6. Initial Owner Account Settup (REQUIRED)

On a fresh database, you must create an owner account manually:
1. Register a user through the `/gymman-sign-up` page.
2. Log into MariaDB and locate that user in the `users` table.
3. Change: `role_id = 3` (member) to `role_id = 1` (owner)
4. Log back in as the owner.

This enables full administrateive access to the system.

# Common Issues
- If you encounter `Access denied for user`, verify:
  - MariaDB is running
  - `db.env` credentials are correct
  - The database user has privileges on `gymman.*`
- If `python` is not found:
  - Use `python3` explicitly
- If packages fail to build:
  - Ensure `libmariadb-dev-compat` is installed