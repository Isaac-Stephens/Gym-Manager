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


-- =========================
-- BIG EXTENTION
-- =========================
-- ============================================================
-- 1. MEMBERS (116 NEW)
-- ============================================================
INSERT INTO Members (first_name, last_name, birth_date, membership_start_date, email, sex) VALUES
('Aaron','Mitchell','1994-01-12','2024-07-15','aaron.mitchell@email.com','Male'),
('Abigail','Cooper','1999-02-27','2024-07-20','abigail.cooper@email.com','Female'),
('Adrian','Ward','1986-03-09','2024-07-22','adrian.ward@email.com','Male'),
('Alyssa','King','2001-04-03','2024-07-23','alyssa.king@email.com','Female'),
('Amelia','Bennett','1992-05-11','2024-07-24','amelia.bennett@email.com','Female'),
('Andrew','Gray','1988-06-13','2024-07-25','andrew.gray@email.com','Male'),
('Angela','Brooks','1979-07-04','2024-07-26','angela.brooks@email.com','Female'),
('Anthony','Howard','1985-08-08','2024-07-28','anthony.howard@email.com','Male'),
('Ariana','Ross','1996-09-19','2024-07-29','ariana.ross@email.com','Female'),
('Austin','Hughes','1990-10-10','2024-07-30','austin.hughes@email.com','Male'),
('Beatrice','Foster','1991-01-12','2024-08-01','beatrice.foster@email.com','Female'),
('Benjamin','Reed','1987-02-21','2024-08-02','benjamin.reed@email.com','Male'),
('Brandon','Ward','1998-03-23','2024-08-03','brandon.ward@email.com','Male'),
('Brianna','Kelly','2002-04-14','2024-08-04','brianna.kelly@email.com','Female'),
('Brooke','Price','1993-05-30','2024-08-05','brooke.price@email.com','Female'),
('Caleb','Peterson','1995-06-25','2024-08-06','caleb.peterson@email.com','Male'),
('Cameron','Bailey','1984-07-18','2024-08-07','cameron.bailey@email.com','Male'),
('Caroline','Gonzalez','1999-08-09','2024-08-08','caroline.gonzalez@email.com','Female'),
('Charles','Long','1977-09-16','2024-08-09','charles.long@email.com','Male'),
('Charlotte','Sanders','1990-10-05','2024-08-10','charlotte.sanders@email.com','Female'),
('Christopher','Bryant','1983-01-18','2024-08-11','christopher.bryant@email.com','Male'),
('Claire','Richardson','1997-02-14','2024-08-12','claire.richardson@email.com','Female'),
('Connor','Simmons','2001-03-19','2024-08-13','connor.simmons@email.com','Male'),
('Courtney','Fisher','1996-04-27','2024-08-14','courtney.fisher@email.com','Female'),
('Daniela','Stevens','1992-05-30','2024-08-15','daniela.stevens@email.com','Female'),
('Derek','Barnes','1980-06-10','2024-08-16','derek.barnes@email.com','Male'),
('Diana','Jenkins','1994-07-12','2024-08-17','diana.jenkins@email.com','Female'),
('Dominic','Warren','1989-08-13','2024-08-18','dominic.warren@email.com','Male'),
('Donna','Fox','1978-09-15','2024-08-19','donna.fox@email.com','Female'),
('Edward','Riley','1985-10-22','2024-08-20','edward.riley@email.com','Male'),
('Elena','Cooper','1993-11-11','2024-08-21','elena.cooper@email.com','Female'),
('Elijah','Price','2000-12-01','2024-08-22','elijah.price@email.com','Male'),
('Ella','Ferguson','1997-01-08','2024-08-23','ella.ferguson@email.com','Female'),
('Elliot','Lane','1992-02-04','2024-08-24','elliot.lane@email.com','Male'),
('Emily','Hayes','1989-03-14','2024-08-25','emily.hayes@email.com','Female'),
('Emma','Woods','2001-04-06','2024-08-26','emma.woods@email.com','Female'),
('Eric','Harrison','1990-05-18','2024-08-27','eric.harrison@email.com','Male'),
('Ethan','Cole','1994-06-19','2024-08-28','ethan.cole@email.com','Male'),
('Eva','Jenkins','1993-07-21','2024-08-29','eva.jenkins@email.com','Female'),
('Evelyn','Scott','1996-08-09','2024-08-30','evelyn.scott@email.com','Female'),
('Faith','Murray','1998-09-10','2024-09-01','faith.murray@email.com','Female'),
('Finn','Freeman','1995-10-12','2024-09-02','finn.freeman@email.com','Male'),
('Gabriel','Hunter','1990-11-15','2024-09-03','gabriel.hunter@email.com','Male'),
('Grace','Stone','1997-12-14','2024-09-04','grace.stone@email.com','Female'),
('Hailey','Owens','1992-01-16','2024-09-05','hailey.owens@email.com','Female'),
('Hannah','Burns','1998-02-22','2024-09-06','hannah.burns@email.com','Female'),
('Harper','Chapman','2000-03-12','2024-09-07','harper.chapman@email.com','Female'),
('Henry','Wells','1991-04-18','2024-09-08','henry.wells@email.com','Male'),
('Hudson','Parker','1986-05-24','2024-09-09','hudson.parker@email.com','Male'),
('Hunter','Bishop','1993-06-15','2024-09-10','hunter.bishop@email.com','Male'),
('Isla','Adams','1997-07-17','2024-09-11','isla.adams@email.com','Female'),
('Jack','Torres','1995-08-28','2024-09-12','jack.torres@email.com','Male'),
('Jade','Flores','1999-09-22','2024-09-13','jade.flores@email.com','Female'),
('Jake','Powell','1996-10-25','2024-09-14','jake.powell@email.com','Male'),
('James','Bennett','1992-11-29','2024-09-15','james.bennett@email.com','Male'),
('Jasmine','Graham','1988-12-31','2024-09-16','jasmine.graham@email.com','Female'),
('Jason','Wallace','1990-01-20','2024-09-17','jason.wallace@email.com','Male'),
('Jayden','Ramos','1999-02-25','2024-09-18','jayden.ramos@email.com','Male'),
('Jeremy','Griffin','1993-03-19','2024-09-19','jeremy.griffin@email.com','Male'),
('Jessica','Watson','1994-04-27','2024-09-20','jessica.watson@email.com','Female'),
('Joanna','Perry','1996-05-30','2024-09-21','joanna.perry@email.com','Female'),
('Jonathan','Ramirez','1989-06-18','2024-09-22','jonathan.ramirez@email.com','Male'),
('Jordan','Sullivan','1992-07-24','2024-09-23','jordan.sullivan@email.com','Male'),
('Jose','Fowler','1988-08-26','2024-09-24','jose.fowler@email.com','Male'),
('Julia','Weaver','1997-09-27','2024-09-25','julia.weaver@email.com','Female'),
('Justin','Harper','1991-10-13','2024-09-26','justin.harper@email.com','Male'),
('Kaitlyn','Barker','1995-11-11','2024-09-27','kaitlyn.barker@email.com','Female'),
('Katherine','Black','1993-12-01','2024-09-28','katherine.black@email.com','Female'),
('Kayla','Woods','1996-01-10','2024-09-29','kayla.woods@email.com','Female'),
('Kevin','Mason','1985-02-04','2024-09-30','kevin.mason@email.com','Male'),
('Kimberly','Porter','1990-03-07','2024-10-01','kimberly.porter@email.com','Female'),
('Kyle','Cruz','1992-04-09','2024-10-02','kyle.cruz@email.com','Male'),
('Landon','Gray','1998-05-13','2024-10-03','landon.gray@email.com','Male'),
('Lauren','Reyes','1999-06-18','2024-10-04','lauren.reyes@email.com','Female'),
('Leah','Price','1995-07-15','2024-10-05','leah.price@email.com','Female'),
('Leo','Watts','1990-08-19','2024-10-06','leo.watts@email.com','Male'),
('Lillian','Hansen','1993-09-09','2024-10-07','lillian.hansen@email.com','Female'),
('Lily','Berry','2000-10-22','2024-10-08','lily.berry@email.com','Female'),
('Logan','Arnold','1996-11-16','2024-10-09','logan.arnold@email.com','Male'),
('Lucas','Lawson','1991-12-20','2024-10-10','lucas.lawson@email.com','Male'),
('Lucy','Mcdonald','1998-01-23','2024-10-11','lucy.mcdonald@email.com','Female'),
('Madison','Wheeler','1997-02-15','2024-10-12','madison.wheeler@email.com','Female'),
('Marcus','Fletcher','1989-03-19','2024-10-13','marcus.fletcher@email.com','Male'),
('Maria','Hawkins','1995-04-17','2024-10-14','maria.hawkins@email.com','Female'),
('Mason','Coleman','2000-05-10','2024-10-15','mason.coleman@email.com','Male'),
('Maya','Griffith','1998-06-09','2024-10-16','maya.griffith@email.com','Female'),
('Megan','Stevens','1993-07-22','2024-10-17','megan.stevens@email.com','Female'),
('Michael','Ford','1987-08-14','2024-10-18','michael.ford@email.com','Male'),
('Molly','Ellis','1992-09-08','2024-10-19','molly.ellis@email.com','Female'),
('Natalie','Payne','1999-10-12','2024-10-20','natalie.payne@email.com','Female'),
('Nathan','Pearson','1995-11-20','2024-10-21','nathan.pearson@email.com','Male'),
('Nicholas','Hicks','1988-12-18','2024-10-22','nicholas.hicks@email.com','Male'),
('Noah','Riley','1994-01-07','2024-10-23','noah.riley@email.com','Male'),
('Olivia','Freeman','2001-02-10','2024-10-24','olivia.freeman@email.com','Female'),
('Owen','Hunt','1996-03-05','2024-10-25','owen.hunt@email.com','Male'),
('Paige','Russell','1998-04-04','2024-10-26','paige.russell@email.com','Female'),
('Patrick','Knight','1989-05-16','2024-10-27','patrick.knight@email.com','Male'),
('Penelope','Dixon','1993-06-21','2024-10-28','penelope.dixon@email.com','Female'),
('Rachel','Ford','1997-07-23','2024-10-29','rachel.ford@email.com','Female'),
('Rebecca','Lane','1991-08-25','2024-10-30','rebecca.lane@email.com','Female'),
('Ryan','Haynes','1995-09-19','2024-10-31','ryan.haynes@email.com','Male'),
('Samantha','Holmes','1992-10-09','2024-11-01','samantha.holmes@email.com','Female'),
('Sarah','Hart','1989-11-15','2024-11-02','sarah.hart@email.com','Female'),
('Scott','Cross','1985-12-19','2024-11-03','scott.cross@email.com','Male'),
('Sofia','Fleming','1999-01-17','2024-11-04','sofia.fleming@email.com','Female'),
('Sophia','Drake','1994-02-25','2024-11-05','sophia.drake@email.com','Female'),
('Spencer','Love','1988-03-29','2024-11-06','spencer.love@email.com','Male'),
('Stella','Page','1993-04-21','2024-11-07','stella.page@email.com','Female'),
('Steven','Rhodes','1992-05-27','2024-11-08','steven.rhodes@email.com','Male'),
('Sydney','Grant','1997-06-16','2024-11-09','sydney.grant@email.com','Female'),
('Thomas','Dean','1985-07-10','2024-11-10','thomas.dean@email.com','Male'),
('Trinity','Myers','2000-08-12','2024-11-11','trinity.myers@email.com','Female'),
('Tyler','Fox','1994-09-22','2024-11-12','tyler.fox@email.com','Male'),
('Victoria','Lloyd','1999-10-15','2024-11-13','victoria.lloyd@email.com','Female'),
('Violet','Ray','1993-11-24','2024-11-14','violet.ray@email.com','Female'),
('William','Reid','1987-12-13','2024-11-15','william.reid@email.com','Male');

-- ============================================================
-- 2. AUTOMATIC PHONE NUMBERS AND EMERGENCY CONTACTS
-- ============================================================
INSERT INTO PhoneNumbers (member_id, phone_number, phone_number_type)
SELECT member_id, CONCAT('555-', LPAD(FLOOR(RAND()*900+100),3,'0'), '-', LPAD(FLOOR(RAND()*9000+1000),4,'0')), 'Mobile'
FROM Members WHERE member_id > 11;

INSERT INTO EmergencyContacts (member_id, first_name, last_name, relationship, phone_number, email)
SELECT member_id, CONCAT('Contact_', member_id), 'Person', 'Friend',
CONCAT('555-', LPAD(FLOOR(RAND()*900+100),3,'0'), '-', LPAD(FLOOR(RAND()*9000+1000),4,'0')),
CONCAT('contact', member_id, '@email.com')
FROM Members WHERE member_id > 11;

-- ============================================================
-- 3. PAYMENTS (MIXED STATUS)
-- ============================================================
INSERT INTO Payments (member_id, amount, payment_date, status)
SELECT member_id, ROUND(30 + RAND()*50, 2),
DATE_ADD('2024-07-01', INTERVAL (member_id-1) DAY),
'Paid'
FROM Members WHERE member_id > 11;

INSERT INTO Payments (member_id, amount, payment_date, status) VALUES
(12, 45.00, '2024-09-15', 'Paid'),
(13, 60.00, '2024-09-18', 'Paid'),
(14, 75.00, '2024-09-22', 'Paid'),
(15, 40.00, '2024-09-25', 'Paid'),
(16, 50.00, '2024-09-26', 'Paid'),
(17, 65.00, NULL, 'Pending'),
(18, 55.00, NULL, 'Pending'),
(19, 70.00, NULL, 'Pending'),
(20, 80.00, '2024-07-01', 'Overdue'),
(21, 95.00, '2024-07-02', 'Overdue'),
(22, 90.00, '2024-07-03', 'Overdue'),
(23, 55.00, '2024-10-01', 'Paid'),
(24, 65.00, '2024-10-02', 'Paid'),
(25, 50.00, '2024-10-03', 'Paid'),
(26, 75.00, '2024-10-04', 'Paid'),
(27, 60.00, '2024-10-05', 'Paid'),
(28, 70.00, '2024-11-15', 'Pending'),
(29, 45.00, '2024-11-16', 'Pending'),
(30, 55.00, '2024-11-17', 'Pending');

-- ============================================================
-- 4. STAFF & ROLES
-- ============================================================
INSERT INTO Staff (ssn, first_name, last_name, employment_date, birth_date, staff_address) VALUES
('999-11-2222','Olivia','Turner','2024-03-10','1990-02-02','100 Oak Cir'),
('999-22-3333','Peter','Moss','2024-04-15','1984-03-03','101 Pine Blvd'),
('999-33-4444','Quinn','Evans','2024-05-20','1992-04-04','102 Birch St'),
('999-44-5555','Riley','Brooks','2024-06-25','1987-05-05','103 Spruce Dr'),
('999-55-6666','Sophie','Reed','2024-07-30','1995-06-06','104 Cedar Ave'),
('999-66-7777','Theo','Bailey','2024-08-10','1989-07-07','105 Walnut Rd'),
('999-77-8888','Uma','Dawson','2024-08-20','1991-08-08','106 Ash Ln'),
('999-88-9999','Victor','Nelson','2024-09-01','1986-09-09','107 Oakridge Blvd'),
('999-99-0000','Wendy','Hart','2024-09-15','1994-10-10','108 Cherry Ct'),
('888-77-6666','Xavier','Fields','2024-09-25','1990-11-11','109 Elm Park');

INSERT INTO Managers (staff_id, shift_managed) VALUES (9, 'Morning'), (10, 'Evening');
INSERT INTO Trainers (staff_id, speciality) VALUES (11, 'Powerlifting'), (12, 'Endurance'), (13, 'CrossFit');
INSERT INTO TrainerCertifications (staff_id, certification_name)
VALUES (11, 'USAPL Coach'), (12, 'Ironman Certified'), (13, 'CrossFit L2');
INSERT INTO Maintainence (staff_id) VALUES (14), (15);
INSERT INTO Contractors (staff_id, contract_type, contract_details)
VALUES (16, 'Landscaping', 'Weekly lawn maintenance and exterior cleaning.');
INSERT INTO Salary_Employees (staff_id, anual_salary) VALUES (11, 58000), (12, 60000), (13, 59000);
INSERT INTO Hourly_Employees (staff_id, hourly_rate) VALUES (9, 23), (10, 21), (14, 18), (15, 19);

-- ============================================================
-- 5. TRAINER-CLIENT RELATIONSHIPS
-- ============================================================
INSERT INTO TrainerClients (trainer_id, member_id, client_start_date, notes) VALUES
(5, 12, '2024-08-01', 'Endurance and cardio intervals'),
(6, 13, '2024-08-02', 'Mobility and flexibility improvement'),
(11, 14, '2024-08-03', 'Powerlifting fundamentals'),
(12, 15, '2024-08-05', 'Ironman prep — swimming focus'),
(13, 16, '2024-08-06', 'Functional HIIT training'),
(5, 17, '2024-08-10', 'Half marathon follow-up program'),
(6, 18, '2024-08-12', 'Light strength maintenance'),
(11, 19, '2024-08-14', 'Deadlift form correction'),
(12, 20, '2024-08-15', 'Weekly endurance circuit'),
(13, 21, '2024-08-18', 'CrossFit intro cycle');

-- ============================================================
-- 6. EXERCISES (Strength + Cardio)
-- ============================================================
INSERT INTO Exercises (member_id, exercise_name, rpe, exercise_date) VALUES
(12, 'Bench Press', 8, '2024-08-02'),
(12, 'Treadmill Run', 7, '2024-08-03'),
(13, 'Squat', 9, '2024-08-04'),
(13, 'Cycling', 6, '2024-08-05'),
(14, 'Deadlift', 9, '2024-08-06'),
(14, 'Rowing', 7, '2024-08-07'),
(15, 'Push-ups', 6, '2024-08-08'),
(16, 'Pull-ups', 8, '2024-08-09'),
(17, 'Overhead Press', 8, '2024-08-10'),
(18, 'Running', 7, '2024-08-11'),
(19, 'Jump Rope', 6, '2024-08-12'),
(20, 'Squat', 9, '2024-08-13'),
(21, 'Cycling', 7, '2024-08-14'),
(22, 'Bench Press', 8, '2024-08-15'),
(23, 'Elliptical', 6, '2024-08-16'),
(24, 'Rowing', 7, '2024-08-17'),
(25, 'Push Press', 9, '2024-08-18'),
(26, 'Treadmill Run', 7, '2024-08-19'),
(27, 'Lunges', 7, '2024-08-20'),
(28, 'Cycling', 6, '2024-08-21'),
(29, 'Bench Press', 9, '2024-08-22'),
(30, 'Rowing', 7, '2024-08-23');

-- ============================================================
-- 7. STRENGTH EXERCISES
-- ============================================================
INSERT INTO Strength_Exercises (exercise_id, exercise_weight, weight_unit, num_sets, num_repetitions, notes) VALUES
(1, 255, 'lbs', 1, 1, 'All time deadlift PR!'),
(2, 215, 'lbs', 1, 1, 'All time squat PR!'),
(3, 185, 'lbs', 3, 8, 'Bench technique solid'),
(5, 0, 'bodyweight', 4, 8, 'Assisted pull-ups using band'),
(7, 205, 'lbs', 3, 8, 'Bench press—solid form'),
(9, 225, 'lbs', 3, 5, 'Squat—new PR'),
(11, 275, 'lbs', 1, 1, 'Heavy deadlift single'),
(13, 0, 'bodyweight', 4, 12, 'Push-up circuit'),
(14, 0, 'bodyweight', 3, 10, 'Pull-ups for endurance'),
(15, 95, 'lbs', 4, 8, 'Overhead press, needs form work'),
(18, 215, 'lbs', 3, 6, 'Strong squat depth'),
(20, 190, 'lbs', 3, 8, 'Bench press progression'),
(23, 125, 'lbs', 3, 10, 'Push press balance improving'),
(25, 0, 'bodyweight', 3, 12, 'Bodyweight lunges—stability training'),
(27, 225, 'lbs', 3, 5, 'Bench press—final testing');

-- ============================================================
-- 8. CARDIO EXERCISES + RUNS + BIKE RIDES
-- ============================================================
INSERT INTO Cardio_Exercises (exercise_id, avg_hr, time_taken) VALUES
(8, 145, '00:25:00'),
(10, 142, '00:35:00'),
(12, 138, '00:20:00'),
(16, 152, '00:30:00'),
(17, 160, '00:15:00'),
(19, 139, '00:40:00'),
(21, 136, '00:45:00'),
(22, 140, '00:30:00'),
(24, 148, '00:30:00'),
(26, 142, '00:40:00'),
(28, 144, '00:35:00');

-- Use correct cardio_id range for Runs and Bike_Rides
INSERT INTO Runs (cardio_id, distance_unit, distance, laps) VALUES
(26, 'miles', 2, 0),
(28, 'km', 5, 0),
(30, 'miles', 3, 0),
(32, 'miles', 4, 0),
(34, 'km', 6, 0),
(36, 'km', 5, 0);

INSERT INTO Bike_Rides (cardio_id, distance_unit, distance, wattage) VALUES
(27, 'miles', 10, 200),
(29, 'miles', 12, 220),
(31, 'km', 15, 230),
(33, 'miles', 8, 180),
(35, 'miles', 14, 250);

