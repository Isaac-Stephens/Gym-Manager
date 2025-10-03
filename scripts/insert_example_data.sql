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
