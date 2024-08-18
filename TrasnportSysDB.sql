CREATE DATABASE IF NOT EXISTS TransportDB;
USE TransportDB;

-- Create the companyEmployee table
CREATE TABLE IF NOT EXISTS companyEmployee (
    empId VARCHAR(10) PRIMARY KEY,
    empName VARCHAR(40),
    empPhoneNo VARCHAR(12),
    empAvailability ENUM('AVAILABLE', 'IN-JOURNEY') DEFAULT 'AVAILABLE'
);

-- Create the busRoute table
CREATE TABLE IF NOT EXISTS busRoute (
    modeType VARCHAR(20) DEFAULT 'BUS',
    busNo VARCHAR(10) PRIMARY KEY,
    totalCapacity INT,
    route VARCHAR(20),
    travelType ENUM('AC', 'NON-AC') NOT NULL,
    travelMode ENUM('SLEEPER', 'NON-SLEEPER'),
    travelDuration INT,
    fareAC FLOAT,        -- Fare for AC travel
    fareNonAC FLOAT,    -- Fare for Non-AC travel
    empId VARCHAR(10),
    FOREIGN KEY (empId) REFERENCES companyEmployee(empId)
);

-- Create the cabRoute table
CREATE TABLE IF NOT EXISTS cabRoute (
    modeType VARCHAR(20) DEFAULT 'CAB',
    cabNo VARCHAR(10) PRIMARY KEY,
    carModel ENUM('MINI', 'PRIME', 'SUV') NOT NULL,
    route VARCHAR(20),
    travelDuration INT,
    fareMini FLOAT,      -- Fare for MINI car model
    farePrime FLOAT,     -- Fare for PRIME car model
    fareSUV FLOAT,       -- Fare for SUV car model
    empId VARCHAR(10),
    FOREIGN KEY (empId) REFERENCES companyEmployee(empId)
);

-- Create the trainRoute table
CREATE TABLE IF NOT EXISTS trainRoute (
    modeType VARCHAR(20) DEFAULT 'TRAIN',
    trainNo VARCHAR(20) PRIMARY KEY,
    totalCapacity INT, 
    route VARCHAR(20),
    travelMode ENUM('SLEEPER', '3 TIER', '2 TIER', '1 CLASS') NOT NULL,
    travelDuration INT,
    fareSleeper FLOAT,   -- Fare for SLEEPER class
    fare3Tier FLOAT,     -- Fare for 3 TIER class
    fare2Tier FLOAT,     -- Fare for 2 TIER class
    fare1Class FLOAT,    -- Fare for 1 CLASS
    empId VARCHAR(10),
    FOREIGN KEY (empId) REFERENCES companyEmployee(empId)
);

-- Create the planeRoute table
CREATE TABLE IF NOT EXISTS planeRoute (
    modeType VARCHAR(20) DEFAULT 'PLANE',
    planeNo VARCHAR(20) PRIMARY KEY,
    totalCapacity INT,
    route VARCHAR(50),
    travelMode ENUM('ECONOMY', 'FIRST CLASS', 'PRIVATE') NOT NULL,
    fareEconomy FLOAT,    -- Fare for ECONOMY class
    fareFirstClass FLOAT, -- Fare for FIRST CLASS
    farePrivate FLOAT,    -- Fare for PRIVATE class
    empId VARCHAR(10),
    FOREIGN KEY (empId) REFERENCES companyEmployee(empId)
);

-- Create the yachtRoute table
CREATE TABLE IF NOT EXISTS yachtRoute (
    modeType VARCHAR(20) DEFAULT 'YACHT',
    yachtNo VARCHAR(20) PRIMARY KEY,
    totalCapacity INT,
    route VARCHAR(50),
    travelMode ENUM('ECONOMY', 'FIRST CLASS', 'PRIVATE') NOT NULL,
    fareEconomy FLOAT,    -- Fare for ECONOMY class
    fareFirstClass FLOAT, -- Fare for FIRST CLASS
    farePrivate FLOAT,    -- Fare for PRIVATE class
    empId VARCHAR(10),
    FOREIGN KEY (empId) REFERENCES companyEmployee(empId)
);

-- Create the userDatabase table
CREATE TABLE IF NOT EXISTS userDatabase (
    userName VARCHAR(60),
    userPhoneNumber VARCHAR(15),
    userAadhar VARCHAR(15) PRIMARY KEY,
    userPassword VARCHAR(18)
);

-- Create the bookingLog table
CREATE TABLE IF NOT EXISTS bookingLog (
    srNo INT,
    userAadhar VARCHAR(15),        -- if this is in the userDatabase, only then book. Else Request Sign-Up
    userPhoneNumber VARCHAR(15),   -- same for this
    travelMode VARCHAR(20),
    travelVehicle ENUM('BUS', 'CAB', 'TRAIN', 'PLANE', 'YACHT') NOT NULL,
    vehicleNo VARCHAR(20),
    ticketsBooked INT,
    totalFare FLOAT,
    FOREIGN KEY (userAadhar) REFERENCES userDatabase(userAadhar)
);

INSERT INTO companyEmployee
(empId, empName, empPhoneNo)
VALUES
("E001", "Employee1", "12345678"),
("E002", "Employee2", "1234568"),
("E003", "Employee3", "1235678"),
("E004", "Employee4", "1235678"),
("E005", "Employee5", "145678"),
("E006", "Employee6", "1678"),
("E007", "Employee7", "12678");

-- Insert initial data into busRoute
INSERT INTO busRoute
    (modeType, busNo, totalCapacity, route, travelType, travelMode, travelDuration, fareAC, fareNonAC, empId)
VALUES
    ('BUS', '1000', 40, 'Mumbai-Pune', 'NON-AC', 'NON-SLEEPER', 4, NULL, 350, 'E001'),
    ('BUS', '1001', 40, 'Mumbai-Pune', 'NON-AC', 'SLEEPER', 4, NULL, 400, 'E002'),
    ('BUS', '1002', 40, 'Mumbai-Pune', 'AC', 'SLEEPER', 4, 500, NULL, 'E003'),
    ('BUS', '1003', 40, 'Mumbai-Pune', 'AC', 'NON-SLEEPER', 4, 450, NULL, 'E004');

-- Insert initial data into cabRoute
INSERT INTO cabRoute
    (modeType, cabNo, carModel, route, travelDuration, fareMini, farePrime, fareSUV, empId)
VALUES
    ('CAB', '4565', 'MINI', 'Mumbai-Pune', 3, 800, NULL, NULL, 'E005'),
    ('CAB', '4566', 'PRIME', 'Mumbai-Pune', 3, NULL, 950, NULL, 'E006'),
    ('CAB', '4567', 'SUV', 'Mumbai-Pune', 3, NULL, NULL, 1500, 'E007');

-- Insert initial data into trainRoute
-- (Adjust with similar pattern if needed)

-- Insert initial data into planeRoute
-- (Adjust with similar pattern if needed)

-- Insert initial data into yachtRoute
-- (Adjust with similar pattern if needed)

-- View data in tables
SELECT * FROM busRoute;
SELECT * FROM cabRoute;
SELECT * FROM trainRoute;
SELECT * FROM planeRoute;
SELECT * FROM companyEmployee;

-- Query to see route-based travel modes and compare prices
SELECT
    route,
    modeType,
    travelMode,
    fareAC AS fare
FROM
    busRoute
WHERE
    route = 'Mumbai-Pune'

UNION ALL

SELECT
    route,
    modeType,
    carModel AS travelMode,
    CASE
        WHEN carModel = 'MINI' THEN fareMini
        WHEN carModel = 'PRIME' THEN farePrime
        WHEN carModel = 'SUV' THEN fareSUV
    END AS fare
FROM
    cabRoute
WHERE
    route = 'Mumbai-Pune';
