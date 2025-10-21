-- ========================================================================
-- Example dataset to be used with Gymman to test and work with. Will be
-- updated as the project goes on. Eventual desktopapplication will include
-- data entry functionality for end user input. Strictly for testing.
-- ========================================================================

-- MEMBERS
INSERT INTO Members (first_name, last_name, birth_date, membership_start_date, email, sex)
VALUES ('Alice', 'Johnson', '1990-05-14', '2024-01-01', 'alice.johnson@email.com', 'Female'); -- member_id = 1 (auto incrementing)

INSERT INTO Members (first_name, last_name, birth_date, membership_start_date, email, sex)
VALUES ('Bob', 'Smith', '1985-09-20', '2024-02-15', 'bob.smith@email.com', 'Male'); -- member_id = 2

-- PHONE NUMBERS
INSERT INTO PhoneNumbers (member_id, phone_number, phone_number_type)
VALUES (1, '555-111-2222', 'Mobile');

INSERT INTO PhoneNumbers (member_id, phone_number, phone_number_type)
VALUES (2, '555-333-4444', 'Home');

-- EMERGENCY CONTACTS
INSERT INTO EmergencyContacts (member_id, first_name, last_name, relationship, phone_number, email)
VALUES (1, 'Carol', 'Johnson', 'Sister', '555-999-8888', 'carol.j@email.com');

INSERT INTO EmergencyContacts (member_id, first_name, last_name, relationship, phone_number, email)
VALUES (2, 'David', 'Smith', 'Father', '555-777-6666', NULL);

-- PAYMENTS
INSERT INTO Payments (member_id, amount, payment_date)
VALUES (1, 50.00, '2024-03-01');

INSERT INTO Payments (member_id, amount, payment_date)
VALUES (2, 75.00, '2024-03-05');

-- STAFF BASE TABLE
INSERT INTO Staff (ssn, first_name, last_name, employment_date, birth_date, staff_address)
VALUES ('123-45-6789', 'Emily', 'Clark', '2022-06-01', '1992-04-10', '123 Main St'); -- staff_id = 1 (auto incrementing)

INSERT INTO Staff (ssn, first_name, last_name, employment_date, birth_date, staff_address)
VALUES ('987-65-4321', 'Frank', 'Miller', '2021-11-15', '1980-07-22', '456 Oak Ave'); -- staff_id = 2

INSERT INTO Staff (ssn, first_name, last_name, employment_date, birth_date, staff_address)
VALUES ('555-66-7777', 'Grace', 'Thompson', '2023-03-10', '1975-08-12', '789 Pine Rd'); -- staff_id = 3

INSERT INTO Staff (ssn, first_name, last_name, employment_date, birth_date, staff_address)
VALUES ('444-55-6666', 'Henry', 'Brown', '2024-01-20', '1995-02-05', '321 Maple Ln'); -- staff_id = 4

-- TRAINERS (Emily is staff_id=1)
INSERT INTO Trainers (staff_id, speciality)
VALUES (1, 'Strength Training');

INSERT INTO TrainerCertifications (staff_id, certification_name)
VALUES (1, 'NASM Certified Personal Trainer');

INSERT INTO TrainerCertifications (staff_id, certification_name)
VALUES (1, 'CPR/AED');

-- TRAINER-CLIENT RELATIONSHIPS
-- Emily (trainer_id=1) trains Alice (member_id=1)
INSERT INTO TrainerClients (trainer_id, member_id, client_start_date, notes)
VALUES (1, 1, '2024-02-01', 'Focus on building endurance');

-- MANAGERS (Frank is staff_id=2)
INSERT INTO Managers (staff_id, shift_managed)
VALUES (2, 'Day');

-- MAINTAINENCE STAFF (Grace is staff_id=3)
INSERT INTO Maintainence (staff_id)
VALUES (3);

-- CONTRACTORS (Henry is staff_id=4)
INSERT INTO Contractors (staff_id, contract_type, contract_details)
VALUES (4, 'Cleaning Contract', 'Responsible for cleaning gym floor and equipment three nights a week.');

-- STAFF PAY TYPES
-- Emily = Salary, Frank = Hourly, Grace = Hourly, Henry = Contractor
INSERT INTO Salary_Employees (staff_id, anual_salary)
VALUES (1, 55000);

INSERT INTO Hourly_Employees (staff_id, hourly_rate)
VALUES (2, 20);

INSERT INTO Hourly_Employees (staff_id, hourly_rate)
VALUES (3, 18);

-- Henry is already in Contractors table (different pay model)

-- EXERCISES
INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (1, 'Deadlift', 9, '2024-02-01');

INSERT INTO Strength_Exercises (exercise_id, exercise_weight, weight_unit, num_sets, num_repetitions, notes)
VALUES (1, 255, 'lbs', 1, 1, 'All time deadlift PR!');

INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date)
VALUES (1, 'Squat', 10, '2024-02-02');

INSERT INTO Strength_Exercises (exercise_id, exercise_weight, weight_unit, num_sets, num_repetitions, notes)
VALUES (2, 215, 'lbs', 1, 1, 'All time squat PR!');

-- =======================
-- Added More Example Data
-- =======================

-- ---------------------------
-- New Members
-- ---------------------------
INSERT INTO Members (first_name, last_name, birth_date, membership_start_date, email, sex) VALUES
('Chloe', 'Martinez', '1993-03-18', '2024-04-01', 'chloe.martinez@email.com', 'Female'),
('Daniel', 'Nguyen', '1988-07-29', '2024-05-10', 'daniel.nguyen@email.com', 'Male'),
('Ella', 'Robinson', '2000-12-02', '2024-06-20', 'ella.robinson@email.com', 'Female'),
('Ronnie', 'Coleman', '1964-05-13', '2024-07-01', 'lightweightbaby@eighttimemrolympia.com', 'Male'),
('Brian', 'Shaw', '1982-02-26', '2024-07-01', 'strongesteva@bigboysonly.com', 'Male'),
('Andy', 'Glaze', '1978-02-18', '2024-08-01', 'smileoryouredoingitwrong@iranfurther', 'Male');

-- ---------------------------
-- New Phone Numbers
-- ---------------------------
INSERT INTO PhoneNumbers (member_id, phone_number, phone_number_type) VALUES
(3, '555-555-1111', 'Mobile'),
(4, '555-555-2222', 'Work'),
(5, '555-555-3333', 'Home');

-- ---------------------------
-- New Emergency Contacts
-- ---------------------------
INSERT INTO EmergencyContacts (member_id, first_name, last_name, relationship, phone_number, email) VALUES
(3, 'Sophia', 'Martinez', 'Mother', '555-111-9999', 'sophia.m@email.com'),
(4, 'Michael', 'Nguyen', 'Brother', '555-222-9999', NULL),
(5, 'Olivia', 'Robinson', 'Sister', '555-333-9999', 'olivia.r@email.com');

-- ---------------------------
-- New Payments
-- ---------------------------
INSERT INTO Payments (member_id, amount, payment_date) VALUES
(3, 60.00, '2024-04-05'),
(4, 80.00, '2024-05-12'),
(5, 55.00, '2024-06-25');

-- ---------------------------
-- Add New Staff
-- ---------------------------
INSERT INTO Staff (ssn, first_name, last_name, employment_date, birth_date, staff_address) VALUES
('111-22-3333', 'Isabella', 'Garcia', '2023-09-01', '1991-11-15', '222 Cedar Blvd'),
('222-33-4444', 'Jack', 'Wilson', '2023-10-10', '1987-02-27', '987 Birch Way'),
('333-44-5555', 'Kara', 'Lopez', '2024-02-15', '1996-08-09', '654 Elm St'),
('444-77-8888', 'Liam', 'Carter', '2022-12-05', '1989-01-21', '159 Spruce Ct');

-- ---------------------------
-- Assign New Trainers
-- ---------------------------
INSERT INTO Trainers (staff_id, speciality) VALUES
(5, 'Cardio Conditioning'),
(6, 'Functional Fitness');

INSERT INTO TrainerCertifications (staff_id, certification_name) VALUES
(5, 'ACE Certified Trainer'),
(5, 'First Aid & CPR'),
(6, 'ISSA Elite Trainer');

-- ---------------------------
-- Assign New Trainer-Client Relationships
-- ---------------------------
INSERT INTO TrainerClients (trainer_id, member_id, client_start_date, client_end_date, notes) VALUES
(5, 3, '2024-05-01', NULL, 'Training for half-marathon'),
(6, 4, '2024-06-01', NULL, 'Focus on mobility and endurance');

-- ---------------------------
-- Add New Manager
-- ---------------------------
INSERT INTO Managers (staff_id, shift_managed) VALUES
(7, 'Night');

-- ---------------------------
-- Add New Contractor
-- ---------------------------
INSERT INTO Contractors (staff_id, contract_type, contract_details) VALUES
(8, 'HVAC Maintenance', 'Maintains and inspects HVAC system monthly.');

-- ---------------------------
-- Add New Hourly / Salary Employees
-- ---------------------------
INSERT INTO Hourly_Employees (staff_id, hourly_rate) VALUES
(7, 22),
(8, 25);

INSERT INTO Salary_Employees (staff_id, anual_salary) VALUES
(5, 48000),
(6, 51000);

-- ---------------------------
-- Add New Exercises (Strength + Cardio)
-- ---------------------------
INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date) VALUES
(3, 'Bench Press', 8, '2024-04-05'),
(3, 'Running', 7, '2024-04-06'),
(4, 'Pull-ups', 9, '2024-05-15'),
(5, 'Cycling', 6, '2024-06-22');

-- Strength Exercises
INSERT INTO Strength_Exercises (exercise_id, exercise_weight, weight_unit, num_sets, num_repetitions, notes) VALUES
(3, 135, 'lbs', 3, 10, 'Improving chest press technique'),
(5, 0, 'bodyweight', 4, 8, 'Assisted pull-ups using band');

-- Cardio Exercises
INSERT INTO Cardio_Exercises (exercise_id, avg_hr, time_taken) VALUES
(4, 150, '00:30:00'),
(6, 140, '00:45:00');

-- Runs
INSERT INTO Runs (cardio_id, distance_unit, distance, laps) VALUES
(1, 'miles', 3, 0);

-- Bike Rides
INSERT INTO Bike_Rides (cardio_id, distance_unit, distance, wattage) VALUES
(2, 'miles', 12, 250);

-- ---------------------------
-- Add New Maintenance Worker
-- ---------------------------
INSERT INTO Maintainence (staff_id) VALUES
(7);

