-- ======================================================================= --
--                            GYMMAN DEMO SCHEMA                           --
--                          Author: Isaac Stephens                         --
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--          Junior, Computer Science, CS Department, Missouri S&T          --
--              issq3r@mst.edu OR isaac.stephens1529@gmail.com             --
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
-- This script will create and fill a complete Database for testing and    --
-- demonstration purposes. Schema is the same as create_gymman_tables.sql, --
-- but includes a LOT of example data. DO NOT use this script if you want  --
-- to utilize this system for your own purposes. I mean you can, but this  --
-- is just random stuff lol                                                --
--                                                                         --
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

-- ====================================================
-- DEMO DATASET
-- ====================================================
START TRANSACTION;

-- =======================
-- INSERT INTO roles
-- =======================
INSERT INTO roles (role_name)
VALUES 
    ('Owner'),
    ('Staff'),
    ('Member'),
    ('Trainer');

-- =======================
-- INSERT INTO users
-- =======================
INSERT INTO users (username, password_hash, role_id, first_name, last_name, email)
VALUES
    ('demo_owner',
        'scrypt:32768:8:1$BiFZ3W1BsOg2Z2o5$8f4e0e36b2c6b25f74f6ac47604b1fe5f11e44d21ac6d5453288d0924474580f9c100f9386bb44e81c2913b5a88d5c1f0e49c8fd8c30ed64ce1680a322cdaf41',
        1, 'Demo', 'Owner', NULL),

    ('demo_staff',
        'scrypt:32768:8:1$BiFZ3W1BsOg2Z2o5$8f4e0e36b2c6b25f74f6ac47604b1fe5f11e44d21ac6d5453288d0924474580f9c100f9386bb44e81c2913b5a88d5c1f0e49c8fd8c30ed64ce1680a322cdaf41',
        2, 'Demo', 'Staff', NULL),

    ('demo_member',
        'scrypt:32768:8:1$BiFZ3W1BsOg2Z2o5$8f4e0e36b2c6b25f74f6ac47604b1fe5f11e44d21ac6d5453288d0924474580f9c100f9386bb44e81c2913b5a88d5c1f0e49c8fd8c30ed64ce1680a322cdaf41',
        3, 'Demo', 'Member', NULL),

    ('demo_trainer',
        'scrypt:32768:8:1$BiFZ3W1BsOg2Z2o5$8f4e0e36b2c6b25f74f6ac47604b1fe5f11e44d21ac6d5453288d0924474580f9c100f9386bb44e81c2913b5a88d5c1f0e49c8fd8c30ed64ce1680a322cdaf41',
        4, 'Demo', 'Trainer', NULL);

-- ============================================================
-- INSERT INTO Members (and associated tables)
-- jump to line 2173 for Staff (this section is LONG, sorry...)
-- ============================================================
INSERT INTO Members (first_name, last_name, birth_date, membership_start_date, email, sex)
VALUES ('Alice', 'Johnson', '1990-05-14', '2024-01-01', 'alice.johnson@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers (member_id, phone_number, phone_number_type)
VALUES (@member_id, '555-111-2222', 'Mobile');

INSERT INTO EmergencyContacts (member_id, first_name, last_name, relationship, phone_number, email)
VALUES (@member_id, 'Carol', 'Johnson', 'Sister', '555-999-8888', 'carol.j@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type)
VALUES 
(@member_id, 50.00, '2024-03-01', 'Complete', 'Cash');

INSERT INTO Checkins (member_id, checkin_datetime)
VALUES
(@member_id, '2025-11-10 13:10:33'),
(@member_id, '2025-11-10 13:23:32'),
(@member_id, '2025-11-10 13:33:33'),
(@member_id, '2025-11-10 14:04:21'),
(@member_id, '2025-11-13 16:35:10');

INSERT INTO Members (first_name, last_name, birth_date, membership_start_date, email, sex)
VALUES ('Bob', 'Smith', '1985-09-20', '2024-02-15', 'bob.smith@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-333-4444', 'Home');

INSERT INTO EmergencyContacts
VALUES (NULL, @member_id, 'David', 'Smith', 'Father', '555-777-6666', NULL);

INSERT INTO Payments (member_id, amount, payment_date, status, type)
VALUES (@member_id, 75.00, '2024-03-05', 'Complete', 'Cash');

INSERT INTO Checkins
VALUES
(NULL, @member_id, '2025-11-10 13:13:03'),
(NULL, @member_id, '2025-11-10 13:36:57'),
(NULL, @member_id, '2025-11-13 16:33:28'),
(NULL, @member_id, '2025-11-13 16:33:37'),
(NULL, @member_id, '2025-11-13 16:36:17'),
(NULL, @member_id, '2025-11-13 16:45:36');

INSERT INTO Members VALUES
(NULL, 'Chloe', 'Martinez', '1993-03-18', '2024-04-01', 'chloe.martinez@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-555-1111', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Sophia', 'Martinez', 'Mother', '555-111-9999', 'sophia.m@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 60.00, '2024-04-05', 'Complete', 'Cash');

INSERT INTO Checkins VALUES
(NULL, @member_id, '2025-11-10 13:19:22');

INSERT INTO Members VALUES
(NULL, 'Daniel', 'Nguyen', '1988-07-29', '2024-05-10', 'daniel.nguyen@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-555-2222', 'Work');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Michael', 'Nguyen', 'Brother', '555-222-9999', NULL);

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 80.00, '2024-05-12', 'Complete', 'Cash');

INSERT INTO Checkins VALUES
(NULL, @member_id, '2025-11-10 14:04:05'),
(NULL, @member_id, '2025-11-10 14:05:52'),
(NULL, @member_id, '2025-11-10 20:43:45');

INSERT INTO Members VALUES
(NULL, 'Ella', 'Robinson', '2000-12-02', '2024-06-20', 'ella.robinson@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-555-3333', 'Home');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Olivia', 'Robinson', 'Sister', '555-333-9999', 'olivia.r@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 55.00, '2024-06-25', 'Pending', 'Cash');

INSERT INTO Checkins VALUES
(NULL, @member_id, '2025-11-10 13:38:10'),
(NULL, @member_id, '2025-11-10 14:04:08'),
(NULL, @member_id, '2025-11-10 20:53:33'),
(NULL, @member_id, '2025-11-10 21:24:53');

INSERT INTO Members VALUES
(NULL, 'Ronnie', 'Coleman', '1964-05-13', '2024-07-01',
 'lightweightbaby@eighttimemrolympia.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-510-5892', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_16', 'Person', 'Friend', '555-491-9580', 'contact16@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 36.23, '2024-07-16', 'Paid', 'Cash');

INSERT INTO Checkins VALUES
(NULL, @member_id, '2025-11-10 13:43:49'),
(NULL, @member_id, '2025-11-13 16:33:42'),
(NULL, @member_id, '2025-11-13 16:33:55');

INSERT INTO Members VALUES
(NULL, 'Brian', 'Shaw', '1982-02-26', '2024-07-01',
 'strongesteva@bigboysonly.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-874-7062', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_17', 'Person', 'Friend', '555-516-5094', 'contact17@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 76.09, '2024-07-21', 'Paid', 'Cash');

INSERT INTO Checkins VALUES
(NULL, @member_id, '2025-11-10 13:36:42'),
(NULL, @member_id, '2025-11-10 13:39:01'),
(NULL, @member_id, '2025-11-12 13:17:01'),
(NULL, @member_id, '2025-11-12 13:27:38');

INSERT INTO Members VALUES
(NULL, 'Andy', 'Glaze', '1978-02-18', '2024-08-01',
 'smileoryouredoingitwrong@iranfurther', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-806-9141', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_18', 'Person', 'Friend', '555-897-1576', 'contact18@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 30.73, '2024-07-23', 'Paid', 'Cash');

INSERT INTO Checkins VALUES
(NULL, @member_id, '2025-11-10 13:37:10'),
(NULL, @member_id, '2025-11-10 13:49:09'),
(NULL, @member_id, '2025-11-10 14:04:15');

INSERT INTO Members VALUES
(NULL, 'Aaron', 'Mitchell', '1994-01-12', '2024-07-15', 'aaron.mitchell@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-251-2131', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_19', 'Person', 'Friend', '555-696-2098', 'contact19@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 38.32, '2024-07-19', 'Paid', 'Cash');

INSERT INTO Members VALUES
(NULL, 'Abigail', 'Cooper', '1999-02-27', '2024-07-20', 'abigail.cooper@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-212-3228', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_20', 'Person', 'Friend', '555-659-7676', 'contact20@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 74.21, '2024-07-20', 'Paid', 'Cash');

INSERT INTO Members VALUES
(NULL, 'Adrian', 'Ward', '1986-03-09', '2024-07-22',
 'adrian.ward@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-876-6150', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_21', 'Person', 'Friend', '555-859-9967', 'contact21@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 76.09, '2024-07-21', 'Paid', 'Cash');

INSERT INTO Members VALUES
(NULL, 'Alyssa', 'King', '2001-04-03', '2024-07-23', 'alyssa.king@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-195-2760', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_12', 'Person', 'Friend', '555-490-4796', 'contact12@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 32.36, '2024-07-12', 'Paid', 'Cash'),
(@member_id, 45.00, '2024-09-15', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Amelia', 'Bennett', '1992-05-11', '2024-07-24',
 'amelia.bennett@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-693-7401', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_13', 'Person', 'Friend', '555-825-7891', 'contact13@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 75.92, '2024-07-13', 'Paid', 'Cash'),
(@member_id, 60.00, '2024-09-18', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Andrew', 'Gray', '1988-06-13', '2024-07-25',
 'andrew.gray@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-619-7779', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_14', 'Person', 'Friend', '555-468-7772', 'contact14@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 52.50, '2024-07-14', 'Paid', 'Cash'),
(@member_id, 75.00, '2024-09-22', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Angela', 'Brooks', '1979-07-04', '2024-07-26',
 'angela.brooks@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-130-9205', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_15', 'Person', 'Friend', '555-579-4659', 'contact15@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 54.74, '2024-07-15', 'Paid', 'Cash'),
(@member_id, 40.00, '2024-09-25', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Anthony', 'Howard', '1985-08-08', '2024-07-28',
 'anthony.howard@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-510-5892', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_16', 'Person', 'Friend', '555-491-9580', 'contact16@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 36.23, '2024-07-16', 'Paid', 'Cash'),
(@member_id, 50.00, '2024-09-26', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Ariana', 'Ross', '1996-09-19', '2024-07-29',
 'ariana.ross@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-415-2096', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_17', 'Person', 'Friend', '555-516-5094', 'contact17@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 36.90, '2024-07-17', 'Paid', 'Cash'),
(@member_id, 65.00, NULL, 'Pending', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Austin', 'Hughes', '1990-10-10', '2024-07-30',
 'austin.hughes@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-601-4798', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_18', 'Person', 'Friend', '555-897-1576', 'contact18@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 45.80, '2024-07-18', 'Paid', 'Cash'),
(@member_id, 55.00, NULL, 'Pending', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Beatrice', 'Foster', '1991-01-12', '2024-08-01',
 'beatrice.foster@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-493-9299', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_19', 'Person', 'Friend', '555-696-2098', 'contact19@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 38.32, '2024-07-19', 'Paid', 'Cash'),
(@member_id, 70.00, NULL, 'Pending', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Benjamin', 'Reed', '1987-02-21', '2024-08-02',
 'benjamin.reed@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-368-7510', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_20', 'Person', 'Friend', '555-659-7676', 'contact20@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 74.21, '2024-07-20', 'Paid', 'Cash'),
(@member_id, 80.00, '2024-07-01', 'Overdue', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Brandon', 'Ward', '1998-03-23', '2024-08-03',
 'brandon.ward@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-284-2983', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_21', 'Person', 'Friend',
 '555-859-9967', 'contact21@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 76.09, '2024-07-21', 'Paid', 'Credit');

INSERT INTO Members VALUES
(NULL, 'Brianna', 'Kelly', '2002-04-14', '2024-08-04',
 'brianna.kelly@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-284-0634', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_22', 'Person', 'Friend',
 '555-047-1526', 'contact22@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 90.00, '2024-07-03', 'Overdue', 'Credit');

INSERT INTO Members VALUES
(NULL, 'Brooke', 'Price', '1993-05-30', '2024-08-05',
 'brooke.price@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-390-8366', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_23', 'Person', 'Friend',
 '555-782-9924', 'contact23@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 55.00, '2024-10-01', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Caleb', 'Peterson', '1995-06-25', '2024-08-06',
 'caleb.peterson@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-096-7457', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_24', 'Person', 'Friend',
 '555-040-8649', 'contact24@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 65.00, '2024-10-02', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Cameron', 'Bailey', '1984-07-18', '2024-08-07',
 'camereron.bailey@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-027-8864', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_25', 'Person', 'Friend',
 '555-705-9003', 'contact25@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 50.00, '2024-10-03', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Caroline', 'Gonzalez', '1999-08-09', '2024-08-08',
 'caroline.gonzalez@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-739-4054', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_26', 'Person', 'Friend',
 '555-812-6603', 'contact26@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 75.00, '2024-10-04', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Charles', 'Long', '1977-09-16', '2024-08-09',
 'charles.long@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-408-1501', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_27', 'Person', 'Friend',
 '555-586-1932', 'contact27@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 60.00, '2024-10-05', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Charlotte', 'Sanders', '1990-10-05', '2024-08-10',
 'charlotte.sanders@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-687-0922', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_28', 'Person', 'Friend',
 '555-932-2952', 'contact28@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 70.00, '2024-11-15', 'Pending', 'Credit');

INSERT INTO Members VALUES
(NULL, 'Christopher', 'Bryant', '1983-01-18', '2024-08-11',
 'christopher.bryant@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-927-5810', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_29', 'Person', 'Friend',
 '555-722-7182', 'contact29@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 45.00, '2024-11-16', 'Pending', 'Credit');

INSERT INTO Members VALUES
(NULL, 'Claire', 'Richardson', '1997-02-14', '2024-08-12',
 'claire.richardson@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL, @member_id, '555-814-0934', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_30', 'Person', 'Friend',
 '555-902-4725', 'contact30@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 55.00, '2024-11-17', 'Pending', 'Credit');

INSERT INTO Members VALUES
(NULL, 'Connor', 'Simmons', '2001-03-19', '2024-08-13',
 'connor.simmons@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-430-0604', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_31', 'Person', 'Friend',
 '555-710-4609', 'contact31@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 52.44, '2024-07-21', 'Paid', 'Credit');

INSERT INTO Members VALUES
(NULL, 'Courtney', 'Fisher', '1996-04-27', '2024-08-14',
 'courtney.fisher@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-791-9250', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_32', 'Person', 'Friend',
 '555-256-5461', 'contact32@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 50.10, '2024-07-22', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Daniela', 'Stevens', '1992-05-30', '2024-08-15',
 'daniela.stevens@email.com', 'Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-461-7712', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_33', 'Person', 'Friend',
 '555-046-5872', 'contact33@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 60.00, '2024-10-01', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Derek', 'Barnes', '1980-06-10', '2024-08-16',
 'derek.barnes@email.com', 'Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-692-9953', 'Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id, 'Contact_34', 'Person', 'Friend',
 '555-904-7842', 'contact34@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 65.00, '2024-10-02', 'Paid', 'Debit');

INSERT INTO Members VALUES
(NULL, 'Diana', 'Jenkins', '1994-07-12', '2024-08-17',
 'diana.jenkins@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL, @member_id, '555-333-8561','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL, @member_id,'Contact_35','Person','Friend',
 '555-712-4960','contact35@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 40.00,'2024-09-25','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Dominic','Warren','1989-08-13','2024-08-18',
 'dominic.warren@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL,@member_id,'555-768-4041','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_36','Person','Friend',
 '555-902-3841','contact36@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id, 70.00,'2024-10-03','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Donna','Fox','1978-09-15','2024-08-19',
 'donna.fox@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL,@member_id,'555-978-4061','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_37','Person','Friend',
 '555-395-9861','contact37@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-10-04','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Edward','Riley','1985-10-22','2024-08-20',
 'edward.riley@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL,@member_id,'555-613-5548','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_38','Person','Friend',
 '555-795-3059','contact38@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.00,'2024-10-05','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Elena','Cooper','1993-11-11','2024-08-21',
 'elena.cooper@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL,@member_id,'555-796-9401','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_39','Person','Friend',
 '555-783-6204','contact39@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-10-06','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Elijah','Price','2000-12-01','2024-08-22',
 'elijah.price@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES (NULL,@member_id,'555-429-7603','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_40','Person','Friend',
 '555-083-2940','contact40@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,95.00,'2024-07-02','Overdue','Credit');

INSERT INTO Members VALUES
(NULL,'Ella','Ferguson','1997-01-08','2024-08-23',
 'ella.ferguson@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-672-9355','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_41','Person','Friend',
 '555-083-7301','contact41@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,90.00,'2024-07-03','Overdue','Credit');

INSERT INTO Members VALUES
(NULL,'Elliot','Lane','1992-02-04','2024-08-24',
 'elliot.lane@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-796-2390','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_42','Person','Friend',
 '555-296-1320','contact42@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,55.00,'2024-10-01','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Emily','Hayes','1989-03-14','2024-08-25',
 'emily.hayes@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-379-7592','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_43','Person','Friend',
 '555-746-5930','contact43@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,65.00,'2024-10-02','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Emma','Woods','2001-04-06','2024-08-26',
 'emma.woods@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-591-4286','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_44','Person','Friend',
 '555-791-7396','contact44@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,50.00,'2024-10-03','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Eric','Harrison','1990-05-18','2024-08-27',
 'eric.harrison@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-418-9571','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_45','Person','Friend',
 '555-930-7448','contact45@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.00,'2024-10-04','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Ethan','Cole','1994-06-19','2024-08-28',
 'ethan.cole@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-703-9844','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_46','Person','Friend',
 '555-194-9043','contact46@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-10-05','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Eva','Jenkins','1993-07-21','2024-08-29',
 'eva.jenkins@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-758-4974','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_47','Person','Friend',
 '555-459-9903','contact47@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,95.00,'2024-07-02','Overdue','Credit');

INSERT INTO Members VALUES
(NULL,'Evelyn','Scott','1996-08-09','2024-08-30',
 'evelyn.scott@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-649-1754','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_48','Person','Friend',
 '555-682-9405','contact48@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,70.00,'2024-10-06','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Faith','Murray','1998-09-10','2024-09-01',
 'faith.murray@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-984-0261','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_49','Person','Friend',
 '555-684-8471','contact49@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-10-07','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Finn','Freeman','1995-10-12','2024-09-02',
 'finn.freeman@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-695-4974','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_50','Person','Friend',
 '555-439-7591','contact50@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.00,'2024-10-08','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Gabriel','Hunter','1990-11-15','2024-09-03',
 'gabriel.hunter@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-703-1659','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_51','Person','Friend',
 '555-602-9574','contact51@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,50.00,'2024-10-09','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Grace','Stone','1997-12-14','2024-09-04',
 'grace.stone@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-074-5974','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_52','Person','Friend',
 '555-508-1934','contact52@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-07-01','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Hailey','Owens','1992-01-16','2024-09-05',
 'hailey.owens@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-942-1759','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_53','Person','Friend',
 '555-840-5761','contact53@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,65.00,'2024-07-02','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Hannah','Burns','1998-02-22','2024-09-06',
 'hannah.burns@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-395-9583','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_54','Person','Friend',
 '555-946-6958','contact54@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.00,'2024-07-03','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Harper','Chapman','2000-03-12','2024-09-07',
 'harper.chapman@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-705-3921','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_55','Person','Friend',
 '555-201-7345','contact55@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,50.00,'2024-07-04','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Henry','Wells','1991-04-18','2024-09-08',
 'henry.wells@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-284-5961','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_56','Person','Friend',
 '555-973-5013','contact56@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,95.00,'2024-07-05','Overdue','Credit');

INSERT INTO Members VALUES
(NULL,'Hudson','Parker','1986-05-24','2024-09-09',
 'hudson.parker@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-781-4096','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_57','Person','Friend',
 '555-764-5083','contact57@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,70.00,'2024-07-06','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Hunter','Bishop','1993-06-15','2024-09-10',
 'hunter.bishop@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-209-6745','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_58','Person','Friend',
 '555-307-4951','contact58@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,85.00,'2024-07-07','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Isla','Adams','1997-07-17','2024-09-11',
 'isla.adams@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-481-7394','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_59','Person','Friend',
 '555-142-9759','contact59@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.00,'2024-07-08','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Jack','Torres','1995-08-28','2024-09-12',
 'jack.torres@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-937-4610','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_60','Person','Friend',
 '555-083-3061','contact60@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,95.00,'2024-07-09','Overdue','Credit');

INSERT INTO Members VALUES
(NULL,'Jade','Flores','1999-09-22','2024-09-13',
 'jade.flores@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-692-1384','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_61','Person','Friend',
 '555-490-2052','contact61@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-10-01','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Jake','Powell','1996-10-25','2024-09-14',
 'jake.powell@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-810-5943','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_62','Person','Friend',
 '555-683-5921','contact62@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,65.00,'2024-10-02','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'James','Bennett','1992-11-29','2024-09-15',
 'james.bennett@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-972-3854','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_63','Person','Friend',
 '555-987-6835','contact63@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,50.00,'2024-10-03','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Jasmine','Graham','1988-12-31','2024-09-16',
 'jasmine.graham@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-472-9510','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_64','Person','Friend',
 '555-104-7594','contact64@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.00,'2024-10-04','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Jason','Wallace','1990-01-20','2024-09-17',
 'jason.wallace@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-760-3928','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_65','Person','Friend',
 '555-473-5962','contact65@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-10-05','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Jayden','Ramos','1999-02-25','2024-09-18',
 'jayden.ramos@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-863-5097','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_66','Person','Friend',
 '555-892-7431','contact66@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,55.00,'2024-10-06','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Jeremy','Griffin','1993-03-19','2024-09-19',
 'jeremy.griffin@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-910-8234','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_67','Person','Friend',
 '555-728-3461','contact67@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-10-07','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Jessica','Watson','1994-04-27','2024-09-20',
 'jessica.watson@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-687-3952','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_68','Person','Friend',
 '555-930-5826','contact68@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,70.00,'2024-10-08','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Joanna','Perry','1996-05-30','2024-09-21',
 'joanna.perry@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-601-7503','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_69','Person','Friend',
 '555-302-7983','contact69@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-10-09','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Jonathan','Ramirez','1989-06-18','2024-09-22',
 'jonathan.ramirez@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-943-4582','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_70','Person','Friend',
 '555-924-5820','contact70@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,85.00,'2024-10-10','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Jordan','Sullivan','1992-07-24','2024-09-23',
 'jordan.sullivan@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-140-3850','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_71','Person','Friend',
 '555-109-6025','contact71@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-10-11','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Jose','Fowler','1988-08-26','2024-09-24',
 'jose.fowler@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-984-2961','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_72','Person','Friend',
 '555-641-9823','contact72@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,95.00,'2024-10-12','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Julia','Weaver','1997-09-27','2024-09-25',
 'julia.weaver@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-583-7401','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_73','Person','Friend',
 '555-018-4933','contact73@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.00,'2024-10-13','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Justin','Harper','1991-10-13','2024-09-26',
 'justin.harper@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-490-6810','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_74','Person','Friend',
 '555-913-2954','contact74@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.00,'2024-10-14','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Kaitlyn','Barker','1995-11-11','2024-09-27',
 'kaitlyn.barker@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-283-4059','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_75','Person','Friend',
 '555-498-1346','contact75@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,65.00,'2024-10-15','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Katherine','Black','1993-12-01','2024-09-28',
 'katherine.black@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-041-2638','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_76','Person','Friend',
 '555-923-5641','contact76@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.00,'2024-10-16','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Kayla','Woods','1996-01-10','2024-09-29',
 'kayla.woods@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-927-5016','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_77','Person','Friend',
 '555-863-3048','contact77@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,65.00,'2024-10-17','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Kevin','Mason','1985-02-04','2024-09-30',
 'kevin.mason@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-703-9201','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_78','Person','Friend',
 '555-740-9531','contact78@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,90.00,'2024-10-18','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Kimberly','Porter','1990-03-07','2024-10-01',
 'kimberly.porter@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-497-2961','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_79','Person','Friend',
 '555-219-5083','contact79@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,65.00,'2024-10-19','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Kyle','Cruz','1992-04-09','2024-10-02',
 'kyle.cruz@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-618-4290','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_80','Person','Friend',
 '555-725-6031','contact80@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.00,'2024-10-20','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Landon','Gray','1998-05-13','2024-10-03',
 'landon.gray@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-875-2161','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_81','Person','Friend',
 '555-688-4212','contact81@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,72.77,'2024-09-19','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Lauren','Reyes','1999-06-18','2024-10-04',
 'lauren.reyes@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-154-9259','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_82','Person','Friend',
 '555-841-1441','contact82@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,52.90,'2024-09-20','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Leah','Price','1995-07-15','2024-10-05',
 'leah.price@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-465-3478','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_83','Person','Friend',
 '555-796-7477','contact83@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,66.19,'2024-09-21','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Leo','Watts','1990-08-19','2024-10-06',
 'leo.watts@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-243-9758','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_84','Person','Friend',
 '555-350-3098','contact84@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,42.24,'2024-09-22','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Lillian','Hansen','1993-09-09','2024-10-07',
 'lillian.hansen@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-447-1110','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_85','Person','Friend',
 '555-397-9574','contact85@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,32.65,'2024-09-23','Paid','Cash');

INSERT INTO Members VALUES
(NULL,'Lily','Berry','2000-10-22','2024-10-08',
 'lily.berry@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-912-5269','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_86','Person','Friend',
 '555-795-1026','contact86@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,56.53,'2024-09-24','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Logan','Arnold','1996-11-16','2024-10-09',
 'logan.arnold@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-698-9129','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_87','Person','Friend',
 '555-728-5340','contact87@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,54.68,'2024-09-25','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Lucas','Lawson','1991-12-20','2024-10-10',
 'lucas.lawson@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-568-9028','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_88','Person','Friend',
 '555-385-2236','contact88@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,73.82,'2024-09-26','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Lucy','Mcdonald','1998-01-23','2024-10-11',
 'lucy.mcdonald@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-909-8383','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_89','Person','Friend',
 '555-762-3429','contact89@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.07,'2024-09-27','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Madison','Wheeler','1997-02-15','2024-10-12',
 'madison.wheeler@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-463-6023','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_90','Person','Friend',
 '555-226-9034','contact90@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,73.89,'2024-09-28','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Marcus','Fletcher','1989-03-19','2024-10-13',
 'marcus.fletcher@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-621-3001','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_91','Person','Friend',
 '555-137-5781','contact91@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,64.24,'2024-09-29','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Maria','Hawkins','1995-04-17','2024-10-14',
 'maria.hawkins@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-436-2817','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_92','Person','Friend',
 '555-577-1549','contact92@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,69.53,'2024-09-30','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Mason','Coleman','2000-05-10','2024-10-15',
 'mason.coleman@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-899-8519','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_93','Person','Friend',
 '555-741-4405','contact93@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,74.92,'2024-10-01','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Maya','Griffith','1998-06-09','2024-10-16',
 'maya.griffith@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-561-1511','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_94','Person','Friend',
 '555-779-6753','contact94@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,35.99,'2024-10-02','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Megan','Stevens','1993-07-22','2024-10-17',
 'megan.stevens@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-771-6036','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_95','Person','Friend',
 '555-938-7676','contact95@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.23,'2024-10-03','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Michael','Ford','1987-08-14','2024-10-18',
 'michael.ford@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-603-2087','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_96','Person','Friend',
 '555-922-4070','contact96@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,38.15,'2024-10-04','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Molly','Ellis','1992-09-08','2024-10-19',
 'molly.ellis@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-931-3332','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_97','Person','Friend',
 '555-969-8247','contact97@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,35.09,'2024-10-05','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Natalie','Payne','1999-10-12','2024-10-20',
 'natalie.payne@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-570-8523','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_98','Person','Friend',
 '555-216-3072','contact98@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,30.97,'2024-10-06','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Nathan','Pearson','1995-11-20','2024-10-21',
 'nathan.pearson@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-650-5957','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_99','Person','Friend',
 '555-787-2147','contact99@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,69.57,'2024-10-07','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Nicholas','Hicks','1988-12-18','2024-10-22',
 'nicholas.hicks@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-927-9490','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_100','Person','Friend',
 '555-411-4151','contact100@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,74.97,'2024-10-08','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Noah','Riley','1994-01-07','2024-10-23',
 'noah.riley@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-963-9693','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_101','Person','Friend',
 '555-739-5545','contact101@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,36.14,'2024-10-09','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Olivia','Freeman','2001-02-10','2024-10-24',
 'olivia.freeman@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-956-8758','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_102','Person','Friend',
 '555-452-5007','contact102@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.80,'2024-10-10','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Owen','Hunt','1996-03-05','2024-10-25',
 'owen.hunt@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-508-7164','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_103','Person','Friend',
 '555-144-9223','contact103@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,40.56,'2024-10-11','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Paige','Russell','1998-04-04','2024-10-26',
 'paige.russell@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-155-3297','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_104','Person','Friend',
 '555-477-4188','contact104@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,45.39,'2024-10-12','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Patrick','Knight','1989-05-16','2024-10-27',
 'patrick.knight@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-181-7172','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_105','Person','Friend',
 '555-562-5563','contact105@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,75.29,'2024-10-13','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Penelope','Dixon','1993-06-21','2024-10-28',
 'penelope.dixon@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-242-7602','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_106','Person','Friend',
 '555-994-5019','contact106@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,60.25,'2024-10-14','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Rachel','Ford','1997-07-23','2024-10-29',
 'rachel.ford@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-304-3586','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_107','Person','Friend',
 '555-326-9290','contact107@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,45.41,'2024-10-15','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Rebecca','Lane','1991-08-25','2024-10-30',
 'rebecca.lane@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-780-9253','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_108','Person','Friend',
 '555-864-5338','contact108@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,66.30,'2024-10-16','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Ryan','Haynes','1995-09-19','2024-10-31',
 'ryan.haynes@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-939-8747','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_109','Person','Friend',
 '555-876-8827','contact109@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,65.27,'2024-10-17','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Samantha','Holmes','1992-10-09','2024-11-01',
 'samantha.holmes@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-555-9542','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_110','Person','Friend',
 '555-783-2673','contact110@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,47.44,'2024-10-18','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Sarah','Hart','1989-11-15','2024-11-02',
 'sarah.hart@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-304-3586','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_111','Person','Friend',
 '555-687-7347','contact111@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,61.40,'2024-10-19','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Scott','Cross','1985-12-19','2024-11-03',
 'scott.cross@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-780-9253','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_112','Person','Friend',
 '555-611-7542','contact112@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,34.66,'2024-10-20','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Sofia','Fleming','1999-01-17','2024-11-04',
 'sofia.fleming@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-385-8537','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_113','Person','Friend',
 '555-936-5188','contact113@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,59.13,'2024-10-21','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Sophia','Drake','1994-02-25','2024-11-05',
 'sophia.drake@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-310-6936','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_114','Person','Friend',
 '555-585-3700','contact114@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,61.65,'2024-10-22','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Spencer','Love','1988-03-29','2024-11-06',
 'spencer.love@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-635-9953','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_115','Person','Friend',
 '555-894-5602','contact115@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,50.88,'2024-10-23','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Stella','Page','1993-04-21','2024-11-07',
 'stella.page@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-270-9683','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_116','Person','Friend',
 '555-919-1146','contact116@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,39.42,'2024-10-24','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Steven','Rhodes','1992-05-27','2024-11-08',
 'steven.rhodes@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-329-4401','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_117','Person','Friend',
 '555-416-7366','contact117@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,64.47,'2024-10-25','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Sydney','Grant','1997-06-16','2024-11-09',
 'sydney.grant@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-213-5475','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_118','Person','Friend',
 '555-534-3645','contact118@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,74.11,'2024-10-26','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Thomas','Dean','1985-07-10','2024-11-10',
 'thomas.dean@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-197-1431','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_119','Person','Friend',
 '555-118-2968','contact119@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,47.14,'2024-10-27','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Trinity','Myers','2000-08-12','2024-11-11',
 'trinity.myers@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-924-4922','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_120','Person','Friend',
 '555-129-5586','contact120@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,33.35,'2024-10-28','Paid','Credit');

INSERT INTO Members VALUES
(NULL,'Tyler','Fox','1994-09-22','2024-11-12',
 'tyler.fox@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-487-8631','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_121','Person','Friend',
 '555-503-7436','contact121@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,45.32,'2024-10-29','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Victoria','Lloyd','1999-10-15','2024-11-13',
 'victoria.lloyd@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-951-2702','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_122','Person','Friend',
 '555-306-1018','contact122@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,46.56,'2024-10-30','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'Violet','Ray','1993-11-24','2024-11-14',
 'violet.ray@email.com','Female');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-195-9661','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_123','Person','Friend',
 '555-389-6427','contact123@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,66.83,'2024-10-31','Paid','Debit');

INSERT INTO Members VALUES
(NULL,'William','Reid','1987-12-13','2024-11-15',
 'william.reid@email.com','Male');
SET @member_id = LAST_INSERT_ID();

INSERT INTO PhoneNumbers VALUES
(NULL,@member_id,'555-544-6250','Mobile');

INSERT INTO EmergencyContacts VALUES
(NULL,@member_id,'Contact_124','Person','Friend',
 '555-144-4953','contact124@email.com');

INSERT INTO Payments (member_id, amount, payment_date, status, type) VALUES
(@member_id,64.50,'2024-11-01','Paid','Debit');

-- ===============================
-- INSERT INTO Staff
-- ===============================
INSERT INTO Staff VALUES
(NULL,'123-45-6789','Emily','Clark','2022-06-01','1992-04-10','123 Main St');
SET @staff1 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'987-65-4321','Frank','Miller','2021-11-15','1980-07-22','456 Oak Ave');
SET @staff2 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'555-66-7777','Grace','Thompson','2023-03-10','1975-08-12','789 Pine Rd');
SET @staff3 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'444-55-6666','Henry','Brown','2024-01-20','1995-02-05','321 Maple Ln');
SET @staff4 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'111-22-3333','Isabella','Garcia','2023-09-01','1991-11-15','222 Cedar Blvd');
SET @staff5 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'222-33-4444','Jack','Wilson','2023-10-10','1987-02-27','987 Birch Way');
SET @staff6 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'333-44-5555','Kara','Lopez','2024-02-15','1996-08-09','654 Elm St');
SET @staff7 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'444-77-8888','Liam','Carter','2022-12-05','1989-01-21','159 Spruce Ct');
SET @staff8 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'999-11-2222','Olivia','Turner','2024-03-10','1990-02-02','100 Oak Cir');
SET @staff9 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'999-22-3333','Peter','Moss','2024-04-15','1984-03-03','101 Pine Blvd');
SET @staff10 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'999-33-4444','Quinn','Evans','2024-05-20','1992-04-04','102 Birch St');
SET @staff11 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'999-44-5555','Riley','Brooks','2024-06-25','1987-05-05','103 Spruce Dr');
SET @staff12 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'999-55-6666','Sophie','Reed','2024-07-30','1995-06-06','104 Cedar Ave');
SET @staff13 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'999-66-7777','Theo','Bailey','2024-08-10','1989-07-07','105 Walnut Rd');
SET @staff14 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'999-77-8888','Uma','Dawson','2024-08-20','1991-08-08','106 Ash Ln');
SET @staff15 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'999-88-9999','Victor','Nelson','2024-09-01','1986-09-09','107 Oakridge Blvd');
SET @staff16 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'999-99-0000','Wendy','Hart','2024-09-15','1994-10-10','108 Cherry Ct');
SET @staff17 = LAST_INSERT_ID();

INSERT INTO Staff VALUES
(NULL,'888-77-6666','Xavier','Fields','2024-09-25','1990-11-11','109 Elm Park');
SET @staff18 = LAST_INSERT_ID();

-- ==============================
-- INSERT INTO Trainers
-- ==============================
INSERT INTO Trainers VALUES
(@staff1, 'Strength Training', TRUE);

INSERT INTO TrainerCertifications VALUES
(NULL, @staff1, 'NASM Certified Personal Trainer'),
(NULL, @staff1, 'CPR/AED');

INSERT INTO Trainers VALUES
(@staff5, 'Cardio Conditioning', TRUE);

INSERT INTO TrainerCertifications VALUES
(NULL, @staff5, 'ACE Certified Trainer'),
(NULL, @staff5, 'First Aid & CPR');

INSERT INTO Trainers VALUES
(@staff6, 'Functional Fitness', TRUE);

INSERT INTO TrainerCertifications VALUES
(NULL, @staff6, 'ISSA Elite Trainer');

INSERT INTO Trainers VALUES
(@staff11, 'Powerlifting', TRUE);

INSERT INTO TrainerCertifications VALUES
(NULL, @staff11, 'USAPL Coach');

INSERT INTO Trainers VALUES
(@staff12, 'Endurance', TRUE);

INSERT INTO TrainerCertifications VALUES
(NULL, @staff12, 'Ironman Certified');

INSERT INTO Trainers VALUES
(@staff13, 'CrossFit', TRUE);

INSERT INTO TrainerCertifications VALUES
(NULL, @staff13, 'CrossFit L2');

-- ===============================
-- Trainer -> Member Relationships
-- ===============================
INSERT INTO TrainerClients VALUES 
(NULL, @staff1, 1, '2024-02-01', NULL, 'Focus on building endurance'),
(NULL, @staff5, 3, '2024-05-01', NULL, 'Training for half-marathon'),
(NULL, @staff6, 4, '2024-06-01', NULL, 'Focus on mobility and endurance'),
(NULL, @staff5, 12, '2024-08-01', NULL, 'Endurance and cardio intervals'),
(NULL, @staff6, 13, '2024-08-02', NULL, 'Mobility and flexibility improvement'),
(NULL, @staff11, 14, '2024-08-03', NULL, 'Powerlifting fundamentals'),
(NULL, @staff12, 15, '2024-08-05', NULL, 'Ironman prep swimming focus'),
(NULL, @staff13, 16, '2024-08-06', NULL, 'Functional HIIT training'),
(NULL, @staff5, 17, '2024-08-10', NULL, 'Half marathon follow-up program'),
(NULL, @staff6, 18, '2024-08-12', NULL, 'Light strength maintenance'),
(NULL, @staff11, 19, '2024-08-14', NULL, 'Deadlift form correction'),
(NULL, @staff12, 20, '2024-08-15', NULL, 'Weekly endurance circuit'),
(NULL, @staff13, 21, '2024-08-18', NULL, 'CrossFit intro cycle');

-- ==============================
-- INSERT INTO Managers
-- ==============================
INSERT INTO Managers VALUES
(@staff2, 'Day'),
(@staff9, 'Morning'),
(@staff10, 'Evening');

-- ==============================
-- INSERT INTO Maintainence
-- ==============================
INSERT INTO Maintainence VALUES
(@staff3),
(@staff7),
(@staff13);

-- ===============================
-- INSERT INTO Contractors
-- ===============================
INSERT INTO Contractors VALUES
(@staff4,  'Cleaning Contract', 'Responsible for cleaning gym floor and equipment three nights a week.'),
(@staff8,  'HVAC Maintenance',  'Maintains and inspects HVAC system monthly.'),
(@staff16, 'Landscaping',       'Weekly lawn maintenance and exterior cleaning.');

-- ===============================
-- Staff Pay Tables
-- ===============================
INSERT INTO Hourly_Employees VALUES
(@staff2, 20),
(@staff3, 18),
(@staff9, 23),
(@staff10, 21),
(@staff7, 22),
(@staff13, 19);

INSERT INTO Salary_Employees VALUES
(@staff1, 55000),
(@staff5, 48000),
(@staff6, 51000),
(@staff11, 58000),
(@staff12, 60000),
(@staff13, 59000);

-- ===============================
-- Exercise Logging Tables
-- ===============================
-- =====================
-- STRENGTH EXERCISES
-- =====================
INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (12, 'Incline Bench Press', 8, '2024-09-10');
SET @s1 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s1, NULL, 155, 'lbs', 3, 8, 'Strong incline session');

INSERT INTO Exercises VALUES (13, NULL, 'Front Squat', 9, '2024-09-11');
SET @s2 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s2, NULL, 185, 'lbs', 4, 5, 'Front squat depth improving');

INSERT INTO Exercises VALUES (14, NULL, 'Romanian Deadlift', 7, '2024-09-12');
SET @s3 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s3, NULL, 205, 'lbs', 3, 8, 'Hamstring-focused');

INSERT INTO Exercises VALUES (15, NULL, 'Seated Shoulder Press', 8, '2024-09-13');
SET @s4 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s4, NULL, 115, 'lbs', 4, 6, 'Good overhead lockout');

INSERT INTO Exercises VALUES (16, NULL, 'Barbell Row', 7, '2024-09-14');
SET @s5 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s5, NULL, 165, 'lbs', 4, 8, 'Clean pulls');

INSERT INTO Exercises VALUES (17, NULL, 'Chest Fly', 6, '2024-09-15');
SET @s6 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s6, NULL, 40, 'lbs', 3, 12, 'Machine chest fly');

INSERT INTO Exercises VALUES (18, NULL, 'Goblet Squat', 7, '2024-09-16');
SET @s7 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s7, NULL, 60, 'lbs', 3, 10, 'Good bracing');

INSERT INTO Exercises VALUES (19, NULL, 'Bent Over Row', 8, '2024-09-17');
SET @s8 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s8, NULL, 175, 'lbs', 5, 5, 'Strong tight rows');

INSERT INTO Exercises VALUES (20, NULL, 'Power Clean', 9, '2024-09-18');
SET @s9 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s9, NULL, 135, 'lbs', 5, 3, 'Explosive movement');

INSERT INTO Exercises VALUES (21, NULL, 'Leg Press', 7, '2024-09-19');
SET @s10 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s10, NULL, 350, 'lbs', 4, 10, 'Full range');

INSERT INTO Exercises VALUES (22, NULL, 'Hip Thrust', 8, '2024-09-20');
SET @s11 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s11, NULL, 275, 'lbs', 4, 6, 'Glute activation strong');

INSERT INTO Exercises VALUES (23, NULL, 'Weighted Pull-ups', 9, '2024-09-21');
SET @s12 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s12, NULL, 45, 'lbs', 3, 5, 'Weighted PR attempt');

INSERT INTO Exercises VALUES (24, NULL, 'Lat Pulldown', 6, '2024-09-22');
SET @s13 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s13, NULL, 120, 'lbs', 4, 12, 'Wide grip focus');

INSERT INTO Exercises VALUES (25, NULL, 'Machine Chest Press', 7, '2024-09-23');
SET @s14 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s14, NULL, 180, 'lbs', 4, 10, 'Even tempo');

INSERT INTO Exercises VALUES (26, NULL, 'Hammer Curl', 6, '2024-09-24');
SET @s15 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s15, NULL, 45, 'lbs', 3, 10, 'Strict curls');

INSERT INTO Exercises VALUES (27, NULL, 'Bicep Curl', 6, '2024-09-25');
SET @s16 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s16, NULL, 35, 'lbs', 3, 12, 'Controlled motion');

INSERT INTO Exercises VALUES (28, NULL, 'Tricep Extension', 6, '2024-09-26');
SET @s17 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s17, NULL, 60, 'lbs', 3, 12, 'Cable extension');

INSERT INTO Exercises VALUES (29, NULL, 'Dumbbell Bench Press', 7, '2024-09-27');
SET @s18 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s18, NULL, 70, 'lbs', 4, 8, 'Good stability');

INSERT INTO Exercises VALUES (30, NULL, 'Dumbbell Shoulder Press', 7, '2024-09-28');
SET @s19 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s19, NULL, 55, 'lbs', 4, 8, 'Smooth reps');

INSERT INTO Exercises VALUES (12, NULL, 'Cable Row', 7, '2024-09-29');
SET @s20 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s20, NULL, 140, 'lbs', 4, 10, 'Good squeeze at end');

INSERT INTO Exercises VALUES (13, NULL, 'Dumbbell Lunges', 8, '2024-09-30');
SET @s21 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s21, NULL, 50, 'lbs', 3, 8, 'Quad-focused');

INSERT INTO Exercises VALUES (14, NULL, 'Good Morning', 7, '2024-10-01');
SET @s22 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s22, NULL, 135, 'lbs', 3, 8, 'Posterior chain strong');

INSERT INTO Exercises VALUES (15, NULL, 'Shrugs', 6, '2024-10-02');
SET @s23 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s23, NULL, 225, 'lbs', 3, 12, 'Heavy shrug session');

INSERT INTO Exercises VALUES (16, NULL, 'Chest Dip', 8, '2024-10-03');
SET @s24 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s24, NULL, 0, 'bodyweight', 4, 10, 'Deep dip work');

INSERT INTO Exercises VALUES (17, NULL, 'Back Extension', 6, '2024-10-04');
SET @s25 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s25, NULL, 45, 'lbs', 3, 12, 'Lower back strengthening');

INSERT INTO Exercises VALUES (18, NULL, 'Kettlebell Swing', 7, '2024-10-05');
SET @s26 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s26, NULL, 70, 'lbs', 3, 15, 'Explosive swings');

INSERT INTO Exercises VALUES (19, NULL, 'Hack Squat', 8, '2024-10-06');
SET @s27 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s27, NULL, 225, 'lbs', 4, 8, 'Quad isolation strong');

INSERT INTO Exercises VALUES (20, NULL, 'Landmine Press', 7, '2024-10-07');
SET @s28 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s28, NULL, 90, 'lbs', 4, 6, 'Core-stability anti-rotation');

INSERT INTO Exercises VALUES (21, NULL, 'Reverse Fly', 6, '2024-10-08');
SET @s29 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s29, NULL, 25, 'lbs', 3, 12, 'Rear delt activation');

INSERT INTO Exercises VALUES (22, NULL, 'Weighted Step-ups', 7, '2024-10-09');
SET @s30 = LAST_INSERT_ID();
INSERT INTO Strength_Exercises VALUES (@s30, NULL, 55, 'lbs', 3, 10, 'Step-up stability')

INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (12, 'Outdoor Run', 7, '2024-09-01');
SET @exA = LAST_INSERT_ID();

INSERT INTO Cardio_Exercises (exercise_id, avg_hr, time_taken)
VALUES (@exA, 150, '00:35:00');
SET @cardA = LAST_INSERT_ID();

INSERT INTO Runs (cardio_id, distance_unit, distance, laps)
VALUES (@cardA, 'miles', 4, 0);

INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (13, 'Steady-State Run', 6, '2024-09-02');
SET @exB = LAST_INSERT_ID();

INSERT INTO Cardio_Exercises (exercise_id, avg_hr, time_taken)
VALUES (@exB, 148, '00:40:00');
SET @cardB = LAST_INSERT_ID();

INSERT INTO Runs (cardio_id, distance_unit, distance, laps)
VALUES (@cardB, 'km', 6, 0);

INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (14, 'Interval Run', 8, '2024-09-03');
SET @exC = LAST_INSERT_ID();

INSERT INTO Cardio_Exercises (exercise_id, avg_hr, time_taken)
VALUES (@exC, 158, '00:28:00');
SET @cardC = LAST_INSERT_ID();

INSERT INTO Runs (cardio_id, distance_unit, distance, laps)
VALUES (@cardC, 'km', 5, 0);

-- =====================================================
-- BIKE RIDES
-- =====================================================

INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (15, 'Road Cycling', 6, '2024-09-04');
SET @exD = LAST_INSERT_ID();

INSERT INTO Cardio_Exercises (exercise_id, avg_hr, time_taken)
VALUES (@exD, 132, '00:55:00');
SET @cardD = LAST_INSERT_ID();

INSERT INTO Bike_Rides (cardio_id, distance_unit, distance, wattage)
VALUES (@cardD, 'miles', 10, 200);

INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (16, 'Endurance Ride', 7, '2024-09-05');
SET @exE = LAST_INSERT_ID();

INSERT INTO Cardio_Exercises (exercise_id, avg_hr, time_taken)
VALUES (@exE, 140, '01:05:00');
SET @cardE = LAST_INSERT_ID();

INSERT INTO Bike_Rides (cardio_id, distance_unit, distance, wattage)
VALUES (@cardE, 'miles', 12, 220);


INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (17, 'Hill Climb', 8, '2024-09-06');
SET @exF = LAST_INSERT_ID();

INSERT INTO Cardio_Exercises (exercise_id, avg_hr, time_taken)
VALUES (@exF, 155, '00:50:00');
SET @cardF = LAST_INSERT_ID();

INSERT INTO Bike_Rides (cardio_id, distance_unit, distance, wattage)
VALUES (@cardF, 'km', 15, 230);

INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (18, 'Sprint Cycling', 9, '2024-09-07');
SET @exG = LAST_INSERT_ID();

INSERT INTO Cardio_Exercises (exercise_id, avg_hr, time_taken)
VALUES (@exG, 165, '00:25:00');
SET @cardG = LAST_INSERT_ID();

INSERT INTO Bike_Rides (cardio_id, distance_unit, distance, wattage)
VALUES (@cardG, 'miles', 8, 180);

INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (19, 'Long Ride', 6, '2024-09-08');
SET @exH = LAST_INSERT_ID();

INSERT INTO Cardio_Exercises (exercise_id, avg_hr, time_taken)
VALUES (@exH, 138, '01:20:00');
SET @cardH = LAST_INSERT_ID();

INSERT INTO Bike_Rides (cardio_id, distance_unit, distance, wattage)
VALUES (@cardH, 'miles', 14, 250);

COMMIT;