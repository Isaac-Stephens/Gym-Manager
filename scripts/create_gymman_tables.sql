------------------------- DEMO USERS (DELETE FOR ACTUAL IMPLEMENTATION) -------------------------

CREATE TABLE roles (
  role_id INT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(50) UNIQUE
);

-- Demo users
INSERT INTO roles (role_name) VALUES ('Owner'), ('Staff'), ('Member'), ('Trainer');

CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role_name VARCHAR(50),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  email VARCHAR(255),
  FOREIGN KEY (role_name) REFERENCES roles(role_name)
);

-- Passwords should be bcrypt-hashed; for demo:
INSERT INTO users (username, password_hash, role_name, first_name, last_name)
VALUES
('demo_owner',  'scrypt:32768:8:1$BiFZ3W1BsOg2Z2o5$8f4e0e36b2c6b25f74f6ac47604b1fe5f11e44d21ac6d5453288d0924474580f9c100f9386bb44e81c2913b5a88d5c1f0e49c8fd8c30ed64ce1680a322cdaf41', 'Owner', 'Demo', 'Owner'),
('demo_staff',  'scrypt:32768:8:1$BiFZ3W1BsOg2Z2o5$8f4e0e36b2c6b25f74f6ac47604b1fe5f11e44d21ac6d5453288d0924474580f9c100f9386bb44e81c2913b5a88d5c1f0e49c8fd8c30ed64ce1680a322cdaf41', 'Staff', 'Demo', 'Staff'),
('demo_member', 'scrypt:32768:8:1$BiFZ3W1BsOg2Z2o5$8f4e0e36b2c6b25f74f6ac47604b1fe5f11e44d21ac6d5453288d0924474580f9c100f9386bb44e81c2913b5a88d5c1f0e49c8fd8c30ed64ce1680a322cdaf41', 'Member', 'Demo', 'Member'),
('demo_trainer','scrypt:32768:8:1$BiFZ3W1BsOg2Z2o5$8f4e0e36b2c6b25f74f6ac47604b1fe5f11e44d21ac6d5453288d0924474580f9c100f9386bb44e81c2913b5a88d5c1f0e49c8fd8c30ed64ce1680a322cdaf41', 'Trainer', 'Demo', 'Trainer');

-------------------------------- MEMBERS --------------------------------
CREATE TABLE Members (
    member_id int AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    membership_start_date DATE,
    email VARCHAR(100) UNIQUE,
    sex VARCHAR(10) -- 'Male', 'Female'
);

CREATE TABLE PhoneNumbers (
    phone_number_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    phone_number_type VARCHAR(20), -- e.g., 'Home', 'Work', 'Mobile'
    CONSTRAINT fk_phone_member FOREIGN KEY (member_id) REFERENCES Members(member_id) -- Only allow phone numbers if member ID already exists
);

-- MEMBER (1) [has] (N) EMERGENCY_CONTACT
CREATE TABLE EmergencyContacts (
    emergency_contact_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    relationship VARCHAR(50),
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(100),

    CONSTRAINT fk_emergency_member FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE CASCADE -- If member is deleted, their emeregency contacts do too.
);

-- MEMBER (0) [pays] (N) PAYMENT
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    member_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE,
    status VARCHAR(50),

    FOREIGN KEY (member_id) REFERENCES Members(member_id) 
);

--------------------------------  STAFF  --------------------------------
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ssn VARCHAR(50) UNIQUE, -- XXX-XX-XXXX
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    employment_date DATE,
    birth_date DATE,
    staff_address VARCHAR(255)
);

-- Subtypes(Staff): Trainers
CREATE TABLE Trainers (
    staff_id INT PRIMARY KEY,
    speciality VARCHAR(255),
    
    CONSTRAINT fk_trainer_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

CREATE TABLE TrainerCertifications (
    trainer_cert_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT NOT NULL,
    certification_name VARCHAR(255) NOT NULL,

    CONSTRAINT fk_cert_staff FOREIGN KEY (staff_id) REFERENCES Trainers(staff_id)
        ON DELETE CASCADE
);

-- Trainer (1) [trains] (N) Members
CREATE TABLE TrainerClients (
    trainer_client_id INT AUTO_INCREMENT PRIMARY KEY,
    trainer_id INT NOT NULL,
    member_id INT NOT NULL,
    client_start_date DATE,
    client_end_date DATE, -- NULL = onging contract
    notes TEXT,

    CONSTRAINT fk_trainer FOREIGN KEY (trainer_id) REFERENCES Trainers(staff_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_client FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE CASCADE,
    CONSTRAINT uq_client_trainer UNIQUE (trainer_id, member_id)
);

-- Subtypes(Staff): Maintainence
CREATE TABLE Maintainence (
    staff_id INT PRIMARY KEY,
-- TODO Maintains equipment relationship
    CONSTRAINT fk_maintainence_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

-- Subtypes(Staff): Managers
CREATE TABLE Managers (
    staff_id INT PRIMARY KEY,
    shift_managed VARCHAR(20), -- Day, Mid, Night

    CONSTRAINT fk_manager_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

-- STAFF PAY TYPES
CREATE TABLE Contractors (
    staff_id INT PRIMARY KEY,
    contract_type VARCHAR(100),
    contract_details TEXT,

    CONSTRAINT fk_contractor_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

CREATE TABLE Hourly_Employees (
    staff_id INT PRIMARY KEY,
    hourly_rate INT,
    CONSTRAINT fk_hourly_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

CREATE TABLE Salary_Employees (
    staff_id INT PRIMARY KEY,
    anual_salary INT,
    CONSTRAINT fk_salary_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE CASCADE
);

--------------------------------- Exercise Logs -------------------------------
CREATE TABLE Exercises (
    member_id INT NOT NULL,
    exercise_id INT AUTO_INCREMENT PRIMARY KEY,
    exercise_name VARCHAR(100) NOT NULL,
    rpe INT,
    exercise_date DATE,
    CONSTRAINT fk_exercise_member FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE CASCADE
);

CREATE TABLE Strength_Exercises (
    exercise_id INT UNIQUE,
    strength_id INT AUTO_INCREMENT PRIMARY KEY,
    exercise_weight INT,
    weight_unit VARCHAR(10), -- pounds/kilograms?
    num_sets INT,
    num_repetitions INT,
    notes TEXT,

    CONSTRAINT fk_strength_exercise FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id)
        ON DELETE CASCADE
);

CREATE TABLE Cardio_Exercises (
    exercise_id INT UNIQUE,
    cardio_id INT AUTO_INCREMENT PRIMARY KEY,
    avg_hr INT,
    time_taken TIME NOT NULL,

    CONSTRAINT fk_cardio_exercise FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id)
        ON DELETE CASCADE
);

CREATE TABLE Runs (
    cardio_id INT PRIMARY KEY,
    distance_unit VARCHAR(20) NOT NULL, -- meters? yards? kilometers? miles?
    distance INT NOT NULL,
    laps INT,

    CONSTRAINT fk_run_cardio FOREIGN KEY (cardio_id) REFERENCES Cardio_Exercises(cardio_id)
        ON DELETE CASCADE
);

CREATE TABLE Bike_Rides (
    cardio_id INT PRIMARY KEY,
    distance_unit VARCHAR(20) NOT NULL,
    distance INT NOT NULL,
    wattage INT,

    CONSTRAINT fk_bike_cardio FOREIGN KEY (cardio_id) REFERENCES Cardio_Exercises (cardio_id)
        ON DELETE CASCADE
);

-- TODO: Machinery Tracking