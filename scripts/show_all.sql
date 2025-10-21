-- ==========================================================
-- Easy little script that shows all tables with titles inline
-- ==========================================================

-- Show Members data
SELECT 'Members' AS TableName, m.*
FROM Members AS m;

-- Show PhoneNumbers
SELECT 'PhoneNumbers' AS TableName, p.*
FROM PhoneNumbers AS p;

-- Show EmergencyContacts
SELECT 'EmergencyContacts' AS TableName, e.*
FROM EmergencyContacts AS e;

-- Show Payments
SELECT 'Payments' AS TableName, p.*
FROM Payments AS p;

-- Show Staff
SELECT 'Staff' AS TableName, s.*
FROM Staff AS s;

-- Show Trainers
SELECT 'Trainers' AS TableName, t.*
FROM Trainers AS t;

-- Show TrainerCertifications
SELECT 'TrainerCertifications' AS TableName, tc.*
FROM TrainerCertifications AS tc;

-- Show TrainerClients
SELECT 'TrainerClients' AS TableName, tc.*
FROM TrainerClients AS tc;

-- Show Maintainence
SELECT 'Maintainence' AS TableName, m.*
FROM Maintainence AS m;

-- Show Managers
SELECT 'Managers' AS TableName, m.*
FROM Managers AS m;

-- Show Contractors
SELECT 'Contractors' AS TableName, c.*
FROM Contractors AS c;

-- Show Hourly_Employees
SELECT 'Hourly_Employees' AS TableName, he.*
FROM Hourly_Employees AS he;

-- Show Salary_Employees
SELECT 'Salary_Employees' AS TableName, se.*
FROM Salary_Employees AS se;

-- Show Exercises
SELECT 'Exercises' AS TableName, e.*
FROM Exercises AS e;

-- Show Strength_Exercises
SELECT 'Strength_Exercises' AS TableName, se.*
FROM Strength_Exercises AS se;

-- Show Cardio_Exercises
SELECT 'Cardio_Exercises' AS TableName, ce.*
FROM Cardio_Exercises AS ce;

-- Show Runs
SELECT 'Runs' AS TableName, r.*
FROM Runs AS r;

-- Show Bike_Rides
SELECT 'Bike_Rides' AS TableName, b.*
FROM Bike_Rides AS b;
