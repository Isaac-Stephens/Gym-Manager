-- ======================================================================= --
--                            GYMMAN: MAIN SCHEMA                          --
--                          Author: Isaac Stephens                         --
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--          Junior, Computer Science, CS Department, Missouri S&T          --
--              issq3r@mst.edu OR isaac.stephens1529@gmail.com             --
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
-- Production schema for personal implementation.                          --
-- A live web demo can be found @ https://isaacstephens.com/gymman-login.  --
-- ======================================================================= --

START TRANSACTION;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Bike_Rides;
DROP TABLE IF EXISTS Runs;
DROP TABLE IF EXISTS Cardio_Exercises;
DROP TABLE IF EXISTS Strength_Exercises;
DROP TABLE IF EXISTS Exercises;

DROP TABLE IF EXISTS TrainerClients;
DROP TABLE IF EXISTS TrainerCertifications;
DROP TABLE IF EXISTS Trainers;

DROP TABLE IF EXISTS Maintainence;
DROP TABLE IF EXISTS Managers;
DROP TABLE IF EXISTS Contractors;
DROP TABLE IF EXISTS Hourly_Employees;
DROP TABLE IF EXISTS Salary_Employees;

DROP TABLE IF EXISTS Staff;

DROP TABLE IF EXISTS Checkins;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS EmergencyContacts;
DROP TABLE IF EXISTS PhoneNumbers;
DROP TABLE IF EXISTS Members;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

SET FOREIGN_KEY_CHECKS = 1;

COMMIT;

START TRANSACTION;

-- -----------------------------------------------------
-- TABLE: roles
-- -----------------------------------------------------
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO roles (role_name)
VALUES 
    ('Owner'),
    ('Staff'),
    ('Member'),
    ('Trainer');

-- -----------------------------------------------------
-- TABLE: users
-- -----------------------------------------------------
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role_id INT,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  email VARCHAR(255),
  FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- -----------------------------------------------------
-- TABLE: Members
-- -----------------------------------------------------
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    membership_start_date DATE,
    email VARCHAR(255),
    sex VARCHAR(10)
);

-- -----------------------------------------------------
-- TABLE: PhoneNumbers
-- -----------------------------------------------------
CREATE TABLE PhoneNumbers (
    phone_number_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    phone_number VARCHAR(20),
    phone_number_type VARCHAR(20),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- -----------------------------------------------------
-- TABLE: EmergencyContacts
-- -----------------------------------------------------
CREATE TABLE EmergencyContacts (
    emergency_contact_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    relationship VARCHAR(50),
    phone_number VARCHAR(20),
    email VARCHAR(255),
    CONSTRAINT fk_emergency_member FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: Payments
-- -----------------------------------------------------
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    member_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE,
    status VARCHAR(50),
    type VARCHAR(50),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- -----------------------------------------------------
-- TABLE: Checkins
-- -----------------------------------------------------
CREATE TABLE Checkins (
    checkin_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    checkin_datetime DATETIME NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- -----------------------------------------------------
-- TABLE: Staff
-- -----------------------------------------------------
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    ssn VARCHAR(20) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    employment_date DATE,
    birth_date DATE,
    staff_address VARCHAR(255)
);

-- -----------------------------------------------------
-- TABLE: Hourly_Employees
-- -----------------------------------------------------
CREATE TABLE Hourly_Employees (
    staff_id INT PRIMARY KEY,
    hourly_rate INT,
    CONSTRAINT fk_hourly_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: Salary_Employees
-- -----------------------------------------------------
CREATE TABLE Salary_Employees (
    staff_id INT PRIMARY KEY,
    anual_salary INT,
    CONSTRAINT fk_salary_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: Maintainence
-- -----------------------------------------------------
CREATE TABLE Maintainence (
    staff_id INT PRIMARY KEY,
    CONSTRAINT fk_maintainence_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: Managers
-- -----------------------------------------------------
CREATE TABLE Managers (
    staff_id INT PRIMARY KEY,
    shift_managed VARCHAR(50),
    CONSTRAINT fk_manager_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: Contractors
-- -----------------------------------------------------
CREATE TABLE Contractors (
    staff_id INT PRIMARY KEY,
    contract_type VARCHAR(255),
    contract_details TEXT,
    CONSTRAINT fk_contractor_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: Trainers
-- -----------------------------------------------------
CREATE TABLE Trainers (
    staff_id INT PRIMARY KEY,
    speciality VARCHAR(255),
    active TINYINT(1),
    CONSTRAINT fk_trainer_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: TrainerCertifications
-- -----------------------------------------------------
CREATE TABLE TrainerCertifications (
    trainer_cert_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT NOT NULL,
    certification_name VARCHAR(255),
    CONSTRAINT fk_cert_staff FOREIGN KEY (staff_id) REFERENCES Trainers(staff_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: TrainerClients
-- -----------------------------------------------------
CREATE TABLE TrainerClients (
    trainer_client_id INT AUTO_INCREMENT PRIMARY KEY,
    trainer_id INT NOT NULL,
    member_id INT NOT NULL,
    client_start_date DATE,
    client_end_date DATE,
    notes TEXT,
    CONSTRAINT fk_trainer FOREIGN KEY (trainer_id) REFERENCES Trainers(staff_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_client FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE CASCADE,
    CONSTRAINT uq_client_trainer UNIQUE (trainer_id, member_id)
);

-- -----------------------------------------------------
-- TABLE: Exercises
-- -----------------------------------------------------
CREATE TABLE Exercises (
    member_id INT NOT NULL,
    exercise_id INT AUTO_INCREMENT PRIMARY KEY,
    exercise_name VARCHAR(255),
    rpe INT,
    exercise_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- -----------------------------------------------------
-- TABLE: Strength_Exercises
-- -----------------------------------------------------
CREATE TABLE Strength_Exercises (
    exercise_id INT PRIMARY KEY,
    strength_id INT,
    exercise_weight INT,
    weight_unit VARCHAR(20),
    num_sets INT,
    num_repetitions INT,
    notes TEXT,
    CONSTRAINT fk_st_ex FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: Cardio_Exercises
-- -----------------------------------------------------
CREATE TABLE Cardio_Exercises (
    exercise_id INT NOT NULL,
    cardio_id INT AUTO_INCREMENT PRIMARY KEY,
    avg_hr INT,
    time_taken TIME,
    CONSTRAINT fk_car_ex FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: Runs
-- -----------------------------------------------------
CREATE TABLE Runs (
    cardio_id INT PRIMARY KEY,
    distance_unit VARCHAR(20),
    distance INT,
    laps INT,
    CONSTRAINT fk_run_car FOREIGN KEY (cardio_id) REFERENCES Cardio_Exercises(cardio_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- TABLE: Bike_Rides
-- -----------------------------------------------------
CREATE TABLE Bike_Rides (
    cardio_id INT PRIMARY KEY,
    distance_unit VARCHAR(20),
    distance INT,
    wattage INT,
    CONSTRAINT fk_bk_car FOREIGN KEY (cardio_id) REFERENCES Cardio_Exercises(cardio_id)
        ON DELETE CASCADE
);

COMMIT;

---o-o- EOF