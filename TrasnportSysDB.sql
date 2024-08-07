CREATE DATABASE IF NOT EXISTS TransportDB;
USE TransportDB;

CREATE TABLE IF NOT EXISTS busRoute (
    modeType VARCHAR(20) DEFAULT "BUS",
    busNo VARCHAR(10) PRIMARY KEY,
    totalCapacity INT,
    route VARCHAR(20),
    travelType ENUM("AC", "NON-AC") NOT NULL,
    travelMode ENUM("SLEEPER", "NON-SLEEPER"),
    travelDuration INT,
    fareAC FLOAT,        -- Fare for AC travel
    fareNonAC FLOAT      -- Fare for Non-AC travel
);

CREATE TABLE IF NOT EXISTS cabRoute (
    modeType VARCHAR(20) DEFAULT "CAB",
    cabNo VARCHAR(10) PRIMARY KEY,
    carModel ENUM("MINI", "PRIME", "SUV") NOT NULL,
    route VARCHAR(20),
    travelDuration INT,
    fareMini FLOAT,      -- Fare for MINI car model
    farePrime FLOAT,     -- Fare for PRIME car model
    fareSUV FLOAT        -- Fare for SUV car model
);

CREATE TABLE IF NOT EXISTS trainRoute (
    modeType VARCHAR(20) DEFAULT "TRAIN",
    trainNo VARCHAR(20) PRIMARY KEY,
    totalCapacity INT, 
    route VARCHAR(20),
    travelMode ENUM("SLEEPER", "3 TIER", "2 TIER", "1 CLASS") NOT NULL,
    travelDuration INT,
    fareSleeper FLOAT,   -- Fare for SLEEPER class
    fare3Tier FLOAT,     -- Fare for 3 TIER class
    fare2Tier FLOAT,     -- Fare for 2 TIER class
    fare1Class FLOAT     -- Fare for 1 CLASS
);

CREATE TABLE IF NOT EXISTS planeRoute (
    modeType VARCHAR(20) DEFAULT "PLANE",
    planeNo VARCHAR(20) PRIMARY KEY,
    totalCapacity INT,
    route VARCHAR(50),
    travelMode ENUM("ECONOMY", "FIRST CLASS", "PRIVATE") NOT NULL,
    fareEconomy FLOAT,    -- Fare for ECONOMY class
    fareFirstClass FLOAT, -- Fare for FIRST CLASS
    farePrivate FLOAT     -- Fare for PRIVATE class
);

CREATE TABLE IF NOT EXISTS yachtRoute(
   modeType VARCHAR(20) DEFAULT "YACHT",
    yachtNo VARCHAR(20) PRIMARY KEY,
    totalCapacity INT,
    route VARCHAR(50),
    travelMode ENUM("ECONOMY", "FIRST CLASS", "PRIVATE") NOT NULL,
    fareEconomy FLOAT,    -- Fare for ECONOMY class
    fareFirstClass FLOAT, -- Fare for FIRST CLASS
    farePrivate FLOAT     -- Fare for PRIVATE class
);

CREATE TABLE IF NOT EXISTS userDatabase(
userName varchar(60),
userPhoneNumber varchar(15),
userAadhar varchar(15) PRIMARY KEY,
userPassword varchar(18)
);  -- this is the database that we will be using. Only registered Users can book from us

CREATE TABLE IF NOT EXISTS bookingLog(
srNo int,
userAadhar varchar(15),
userPhoneNumber varchar(15),
travelMode varchar(20),
travelVehicle enum("BUS", "CAB", "TRAIN", "PLANE", "YACHT") NOT NULL,
vehicleNo varchar(20),
ticketsBooked int,
totalFare float,
FOREIGN KEY (userAadhar) REFERENCES userDatabase(userAadhar)
);

-- This is the section where we add the base raw data in this. At least the initial one.

-- This is the view part to see the basic tables and their schema
SELECT * FROM busRoute;
SELECT * FROM cabRoute;
SELECT * FROM trainRoute;
SELECT * FROM planeRoute;
