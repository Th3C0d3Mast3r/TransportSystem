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
    fareAC FLOAT, -- Fare for AC travel
    fareNonAC FLOAT, -- Fare for Non-AC travel
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
    fareMini FLOAT, -- Fare for MINI car model
    farePrime FLOAT, -- Fare for PRIME car model
    fareSUV FLOAT, -- Fare for SUV car model
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
		fareSleeper FLOAT, -- Fare for SLEEPER class
		fare3Tier FLOAT, -- Fare for 3 TIER class
		fare2Tier FLOAT, -- Fare for 2 TIER class
		fare1Class FLOAT, -- Fare for 1 CLASS
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
    travelDuration  INT, 
    fareEconomy FLOAT, -- Fare for ECONOMY class
    fareFirstClass FLOAT, -- Fare for FIRST CLASS
    farePrivate FLOAT, -- Fare for PRIVATE class
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

ALTER TABLE userDatabase
ADD createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

INSERT INTO userDatabase
(userName, userPhoneNumber, userAadhar, userPassword)
VALUES
("User1", "1234567890", "1155997788", "passwordss");
SELECT * FROM userDatabase;

-- Create the bookingLog table
CREATE TABLE IF NOT EXISTS bookingLog (
    srNo INT,
    userAadhar VARCHAR(15), -- if this is in the userDatabase, only then book. Else Request Sign-Up
    userPhoneNumber VARCHAR(15), -- same for this
    travelMode VARCHAR(20),
    travelVehicle ENUM('BUS', 'CAB', 'TRAIN', 'PLANE', 'YACHT') NOT NULL,
    vehicleNo VARCHAR(20),
    ticketsBooked INT,
    totalFare FLOAT,
    FOREIGN KEY (userAadhar) REFERENCES userDatabase(userAadhar)
);

-- for the case of admin of employee
INSERT INTO companyEmployee
(empID, empName, empPhoneNo)
VALUES
("AD001", "Devesh", "0000000001"),
("AD002", "Atharv", "0000000002"),
("AD003", "Yug", "0000000003");

INSERT INTO companyEmployee
(empId, empName, empPhoneNo)
VALUES
("E0001", "Mark Gupta", "9863145478"), ("E0002", "Andrew Sharma", "9863145478"), ("E0003", "Nitin Yadav", "9863145478"),
("E0004", "Rajesh Pal", "9863145478"), ("E0005", "Mukesh Singh", "9863145478"), ("E0006", "Ali Khan", "9863145478"),
("E0007", "Mustafa Nawab", "9863145478"), ("E0008", "Om Ashtekar", "9863145478"), ("E0009", "Mohit Pandey", "9863145478"),
("E0010", "Nikhil Valani", "9863145478"), ("E0011", "Suresh Shah", "9863145478"), ("E0012", "Bittu Jha", "9863145478"),
("E0013", "Bhuvan Pania", "9863145478"), ("E0014", "Ishaan Mehta", "9863145478"), ("E0015", "Aditya Joshi", "9863145478"),
("E0016", "Siddharth Rao", "9863145478"), ("E0017", "Karan Thakur", "9863145478"), ("E0018", "Rohit Kapoor", "9863145478"),
("E0019", "Ankita Patel", "9863145478"), ("E0020", "Ravi Sinha", "9863145478"), ("E0021", "Vinay Shetty", "9863145478"),
("E0022", "Arjun Desai", "9863145478"), ("E0023", "Gaurav Malhotra", "9863145478"), ("E0024", "Tanay Saxena", "9863145478"),
("E0025", "Priyanshu Iyer", "9863145478"), ("E0026", "Manish Verma", "9863145478"), ("E0027", "Shiv Agarwal", "9863145478"),
("E0028", "Deepak Mishra", "9863145478"), ("E0029", "Parth Arora", "9863145478"), ("E0030", "Harsh Vardhan", "9863145478");

INSERT INTO companyEmployee
(empId, empName, empPhoneNo)
VALUES
("E0031", "Suresh Kumar", "9654321098"), ("E0032", "Priyank Singh", "9543210987"), ("E0033", "Rahul Verma", "9432109876"),
("E0034", "Karan Reddy", "9321098765"), ("E0035", "Nishant Joshi", "9210987654"), ("E0036", "Mohammed Ali", "9109876543"),
("E0037", "Atman Mehta", "9098765432"), ("E0038", "Vijay Patil", "8987654321"), ("E0039", "Sodhi Kapoor", "8876543210"),
("E0040", "Ajay Bhatia", "8765432109"), ("E0041", "Mayur Iyer", "8654321098"), ("E0042", "Rakesh Jain", "8543210987"),
("E0043", "Tanay Chatterjee", "8432109876"), ("E0044", "Deepak Noir", "8321098765"), ("E0045", "Anant Desai", "8210987654"),
("E0046", "Vikram Singh", "8109876543"), ("E0047", "Soham Patil", "8098765432"), ("E0048", "Gaurav Sharma", "7987654321"),
("E0049", "Sneh Bansal", "7876543210"), ("E0050", "Rajesh Gutka", "7765432109"), ("E0051", "Nitin Sinha", "7654321098"),
("E0052", "Alok Yadav", "7543210987"), ("E0053", "Megh Mehta", "7432109876"), ("E0054", "Siddharth Bhatia", "7321098765"),
("E0055", "Joshila Joshi", "7210987654"), ("E0056", "Dabang Sharma", "7109876543"), ("E0057", "Garma Verma", "7098765432"),
("E0058", "Karan Kapoor", "6987654321"), ("E0059", "Reddy Iyer", "6876543210"), ("E0060", "Aditya Chougule", "6765432109"),
("E0061", "Vishal Deshmukh", "6654321098"), ("E0062", "Akash Gupta", "6543210987"), ("E0063", "Rohan Malik", "6432109876"),
("E0064", "Tan Sethi", "6321098765"), ("E0065", "Manish Kumar", "6210987654"), ("E0066", "Saksham Sharma", "6109876543"),
("E0067", "Himanshu Bansal", "6098765432"), ("E0068", "Kavya Mehta", "5987654321"), ("E0069", "Sourabh Yadav", "5876543210"),
("E0070", "Shereesh Sinha", "5765432109"), ("E0071", "Ajit Reddy", "5654321098"), ("E0072", "Chaitany Joshi", "5543210987"),
("E0073", "Ankush Sharma", "5432109876"), ("E0074", "Akon Iyer", "5321098765"), ("E0075", "Rajendra Yadav", "5210987654"),
("E0076", "Pavan Patil", "5109876543"), ("E0077", "Ankur Kapoor", "5098765432"), ("E0078", "Devendra Kumar", "4987654321"),
("E0079", "Neeraj Gupta", "4876543210"), ("E0080", "Kota Bansal", "4765432109"), ("E0081", "Nikhil Yadav", "4654321098"),
("E0082", "Parvesh Mehta", "4543210987"), ("E0083", "Sanjay Sharma", "4432109876"), ("E0084", "Tushar Joshi", "4321098765"),
("E0085", "Kajal Verma", "4210987654"), ("E0086", "Dinesh Reddy", "4109876543"), ("E0087", "Aditi Singh", "4098765432"),
("E0088", "Nitin Kapoor", "3987654321"), ("E0089", "Uday Sinha", "3876543210"), ("E0090", "Komal Iyer", "3765432109"),
("E0091", "Ashish Bansal", "3654321098"), ("E0092", "Anuradha Mehta", "3543210987"), ("E0093", "Deepesh Kumar", "3432109876"),
("E0094", "Sandeep Joshi", "3321098765"), ("E0095", "Ruchi Sharma", "3210987654"), ("E0096", "Vikas Reddy", "3109876543"),
("E0097", "Maya Singh", "3098765432"), ("E0098", "Alok Patel", "2987654321"), ("E0099", "Snehal Gupta", "2876543210"),
("E0100", "Dev Joshi", "2765432109");

-- Insert initial data into busRoute
INSERT INTO busRoute
    (modeType, busNo, totalCapacity, route, travelType, travelMode, travelDuration, fareAC, fareNonAC, empId)
VALUES
    ('BUS', '1000', 40, 'Mumbai-Pune', 'NON-AC', 'NON-SLEEPER', 4, NULL, 350, 'E0001'),
    ('BUS', '1001', 40, 'Mumbai-Pune', 'NON-AC', 'SLEEPER', 4, NULL, 400, 'E0002'),
    ('BUS', '1002', 40, 'Mumbai-Pune', 'AC', 'SLEEPER', 4, 500, NULL, 'E0003'),
    ('BUS', '1003', 40, 'Mumbai-Pune', 'AC', 'NON-SLEEPER', 4, 450, NULL, 'E0004'),
    
    ('BUS', '1004', 40, 'Delhi-Jaipur', 'AC', 'SLEEPER', 6, 800, NULL, 'E0005'),
    ('BUS', '1005', 40, 'Delhi-Jaipur', 'AC', 'NON-SLEEPER', 6, 650, NULL, 'E0006'),
    
    ('BUS', '1006', 40, 'Madurai-Coimbatore', 'AC', 'SLEEPER', 4, 500, NULL, 'E0007'),
    ('BUS', '1007', 40, 'Madurai-Coimbatore', 'AC', 'NON-SLEEPER', 4, 450, NULL, 'E0008'),
    
    ('BUS', '1008', 40, 'Mumbai-Delhi', 'NON-AC', 'NON-SLEEPER', 18, NULL, 1100, 'E0009'),
    ('BUS', '1009', 40, 'Mumbai-Delhi', 'NON-AC', 'SLEEPER', 18, NULL, 1300, 'E0010'),
    ('BUS', '1010', 40, 'Mumbai-Delhi', 'AC', 'SLEEPER', 18, 1600, NULL, 'E0011'),
    ('BUS', '1011', 40, 'Mumbai-Delhi', 'AC', 'NON-SLEEPER', 18, 1400, NULL, 'E0012'),
    
    ('BUS', '1012', 40, 'Pune-Nagpur', 'NON-AC', 'NON-SLEEPER', 13, NULL, 900, 'E0013'),
    ('BUS', '1013', 40, 'Pune-Nagpur', 'NON-AC', 'SLEEPER', 13, NULL, 1100, 'E0014'),
    ('BUS', '1014', 40, 'Pune-Nagpur', 'AC', 'SLEEPER', 13, 1300, NULL, 'E0015'),
    ('BUS', '1015', 40, 'Pune-Nagpur', 'AC', 'NON-SLEEPER', 13, 1200, NULL, 'E0016'),
    
    ('BUS', '1016', 40, 'Mumbai-Indore', 'NON-AC', 'NON-SLEEPER', 10, NULL, 750, 'E0017'),
    ('BUS', '1017', 40, 'Mumbai-Indore', 'NON-AC', 'SLEEPER', 10, NULL, 900, 'E0018'),
    ('BUS', '1018', 40, 'Mumbai-Indore', 'AC', 'SLEEPER', 10, 1100, NULL, 'E0019'),
    ('BUS', '1019', 40, 'Mumbai-Indore', 'AC', 'NON-SLEEPER', 10, 1000, NULL, 'E0020'),
    
    ('BUS', '1020', 40, 'Bangalore-Chennai', 'AC', 'SLEEPER', 6, 700, NULL, 'E0021'),
    ('BUS', '1021', 40, 'Bangalore-Chennai', 'AC', 'NON-SLEEPER', 6, 600, NULL, 'E0022'),
    
    ('BUS', '1022', 40, 'Hyderabad-Vijayawada', 'NON-AC', 'NON-SLEEPER', 5, NULL, 400, 'E0023'),
    ('BUS', '1023', 40, 'Hyderabad-Vijayawada', 'NON-AC', 'SLEEPER', 5, NULL, 500, 'E0024'),
    ('BUS', '1024', 40, 'Hyderabad-Vijayawada', 'AC', 'SLEEPER', 5, 600, NULL, 'E0025'),
    ('BUS', '1025', 40, 'Hyderabad-Vijayawada', 'AC', 'NON-SLEEPER', 5, 550, NULL, 'E0026'),
    
    ('BUS', '1026', 40, 'Mumbai-Goa', 'AC', 'SLEEPER', 12, 1400, NULL, 'E0029'),
    ('BUS', '1027', 40, 'Mumbai-Goa', 'NON-AC', 'SLEEPER', 12, NULL, 1200, 'E0027'),
    
    ('BUS', '1028', 40, 'Chennai-Bangalore', 'AC', 'NON-SLEEPER', 6, 600, NULL, 'E0028'),
    ('BUS', '1029', 40, 'Chennai-Bangalore', 'AC', 'SLEEPER', 6, 700, NULL, 'E0030'),
    
    ('BUS', '1030', 40, 'Kolkata-Ranchi', 'NON-AC', 'NON-SLEEPER', 7, NULL, 500, 'E0027'),
    ('BUS', '1031', 40, 'Kolkata-Ranchi', 'AC', 'SLEEPER', 7, 800, NULL, 'E0030');

-- Insert initial data into cabRoute
INSERT INTO cabRoute
    (modeType, cabNo, carModel, route, travelDuration, fareMini, farePrime, fareSUV, empId)
VALUES
    -- Mumbai-Pune Route
    ('CAB', '4565', 'MINI', 'Mumbai-Pune', 3, 800, NULL, NULL, 'E0031'),
    ('CAB', '4566', 'PRIME', 'Mumbai-Pune', 3, NULL, 950, NULL, 'E0032'),
    ('CAB', '4567', 'SUV', 'Mumbai-Pune', 3, NULL, NULL, 1500, 'E0033'),
    
    ('CAB', '4568', 'MINI', 'Delhi-Jaipur', 4, 1200, NULL, NULL, 'E0034'),
    ('CAB', '4569', 'PRIME', 'Delhi-Jaipur', 4, NULL, 1500, NULL, 'E0035'),
    ('CAB', '4570', 'SUV', 'Delhi-Jaipur', 4, NULL, NULL, 2200, 'E0036'),
    
    ('CAB', '4571', 'MINI', 'Madurai-Coimbatore', 3, 1000, NULL, NULL, 'E0037'),
    ('CAB', '4572', 'PRIME', 'Madurai-Coimbatore', 3, NULL, 1300, NULL, 'E0038'),
    ('CAB', '4573', 'SUV', 'Madurai-Coimbatore', 3, NULL, NULL, 1800, 'E0039'),
    
    ('CAB', '4574', 'MINI', 'Mumbai-Delhi', 16, 3000, NULL, NULL, 'E0040'),
    ('CAB', '4575', 'PRIME', 'Mumbai-Delhi', 16, NULL, 3500, NULL, 'E0041'),
    ('CAB', '4576', 'SUV', 'Mumbai-Delhi', 16, NULL, NULL, 5000, 'E0042'),
    
    ('CAB', '4577', 'MINI', 'Pune-Nagpur', 12, 2000, NULL, NULL, 'E0043'),
    ('CAB', '4578', 'PRIME', 'Pune-Nagpur', 12, NULL, 2500, NULL, 'E0044'),
    ('CAB', '4579', 'SUV', 'Pune-Nagpur', 12, NULL, NULL, 4000, 'E0045'),
    
    ('CAB', '4580', 'MINI', 'Mumbai-Indore', 9, 1500, NULL, NULL, 'E0046'),
    ('CAB', '4581', 'PRIME', 'Mumbai-Indore', 9, NULL, 1800, NULL, 'E0047'),
    ('CAB', '4582', 'SUV', 'Mumbai-Indore', 9, NULL, NULL, 3000, 'E0048'),
    
    ('CAB', '4583', 'MINI', 'Bangalore-Chennai', 5, 900, NULL, NULL, 'E0049'),
    ('CAB', '4584', 'PRIME', 'Bangalore-Chennai', 5, NULL, 1200, NULL, 'E0050'),
    ('CAB', '4585', 'SUV', 'Bangalore-Chennai', 5, NULL, NULL, 2000, 'E0031'),
    
    ('CAB', '4586', 'MINI', 'Hyderabad-Vijayawada', 5, 700, NULL, NULL, 'E0032'),
    ('CAB', '4587', 'PRIME', 'Hyderabad-Vijayawada', 5, NULL, 1000, NULL, 'E0033'),
    ('CAB', '4588', 'SUV', 'Hyderabad-Vijayawada', 5, NULL, NULL, 1500, 'E0034'),
    
    ('CAB', '4589', 'MINI', 'Mumbai-Goa', 6, 2500, NULL, NULL, 'E0035'),
    ('CAB', '4590', 'PRIME', 'Mumbai-Goa', 6, NULL, 3000, NULL, 'E0036'),
    ('CAB', '4591', 'SUV', 'Mumbai-Goa', 6, NULL, NULL, 4500, 'E0037'),

    ('CAB', '4592', 'MINI', 'Kolkata-Ranchi', 6, 1200, NULL, NULL, 'E0038'),
    ('CAB', '4593', 'PRIME', 'Kolkata-Ranchi', 6, NULL, 1500, NULL, 'E0039'),
    ('CAB', '4594', 'SUV', 'Kolkata-Ranchi', 6, NULL, NULL, 2500, 'E0040');

INSERT INTO trainRoute
    (modeType, trainNo, totalCapacity, route, travelMode, travelDuration, fareSleeper, fare3Tier, fare2Tier, fare1Class, empId)
VALUES
    ('TRAIN', 'T001A', 800, 'Mumbai-Delhi', 'SLEEPER', 16, 900, NULL, NULL, NULL, 'E0041'),
    ('TRAIN', 'T001B', 800, 'Mumbai-Delhi', '3 TIER', 16, NULL, 1600, NULL, NULL, 'E0041'),
    ('TRAIN', 'T001C', 800, 'Mumbai-Delhi', '2 TIER', 16, NULL, NULL, 2500, NULL, 'E0041'),
    ('TRAIN', 'T001D', 800, 'Mumbai-Delhi', '1 CLASS', 16, NULL, NULL, NULL, 4000, 'E0041'),

    ('TRAIN', 'T002A', 800, 'Delhi-Jaipur', 'SLEEPER', 5, 600, NULL, NULL, NULL, 'E0042'),
    ('TRAIN', 'T002B', 800, 'Delhi-Jaipur', '3 TIER', 5, NULL, 1500, NULL, NULL, 'E0042'),
    ('TRAIN', 'T002C', 800, 'Delhi-Jaipur', '2 TIER', 5, NULL, NULL, 2300, NULL, 'E0042'),
    ('TRAIN', 'T002D', 800, 'Delhi-Jaipur', '1 CLASS', 5, NULL, NULL, NULL, 3800, 'E0042'),

    ('TRAIN', 'T003A', 800, 'Mumbai-Pune', 'SLEEPER', 3, 700, NULL, NULL, NULL, 'E0043'),
    ('TRAIN', 'T003B', 800, 'Mumbai-Pune', '3 TIER', 3, NULL, 1000, NULL, NULL, 'E0043'),
    ('TRAIN', 'T003C', 800, 'Mumbai-Pune', '2 TIER', 3, NULL, NULL, 1600, NULL, 'E0043'),
    ('TRAIN', 'T003D', 800, 'Mumbai-Pune', '1 CLASS', 3, NULL, NULL, NULL, 2580, 'E0043'),

    ('TRAIN', 'T004A', 800, 'Bangalore-Hyderabad', 'SLEEPER', 12, 950, NULL, NULL, NULL, 'E0044'),
    ('TRAIN', 'T004B', 800, 'Bangalore-Hyderabad', '3 TIER', 12, NULL, 1600, NULL, NULL, 'E0044'),
    ('TRAIN', 'T004C', 800, 'Bangalore-Hyderabad', '2 TIER', 12, NULL, NULL, 2800, NULL, 'E0044'),
    ('TRAIN', 'T004D', 800, 'Bangalore-Hyderabad', '1 CLASS', 12, NULL, NULL, NULL, 4500, 'E0044'),

    ('TRAIN', 'T005A', 800, 'Kolkata-Patna', 'SLEEPER', 12, 900, NULL, NULL, NULL, 'E0045'),
    ('TRAIN', 'T005B', 800, 'Kolkata-Patna', '3 TIER', 12, NULL, 1980, NULL, NULL, 'E0045'),
    ('TRAIN', 'T005C', 800, 'Kolkata-Patna', '2 TIER', 12, NULL, NULL, 2965, NULL, 'E0045'),
    ('TRAIN', 'T005D', 800, 'Kolkata-Patna', '1 CLASS', 12, NULL, NULL, NULL, 4400, 'E0045'),

    ('TRAIN', 'T006A', 800, 'Chennai-Madurai', 'SLEEPER', 8, 850, NULL, NULL, NULL, 'E0046'),
    ('TRAIN', 'T006B', 800, 'Chennai-Madurai', '3 TIER', 8, NULL, 1230, NULL, NULL, 'E0046'),
    ('TRAIN', 'T006C', 800, 'Chennai-Madurai', '2 TIER', 8, NULL, NULL, 2000, NULL, 'E0046'),
    ('TRAIN', 'T006D', 800, 'Chennai-Madurai', '1 CLASS', 8, NULL, NULL, NULL, 3000, 'E0046'),

    ('TRAIN', 'T007A', 800, 'Delhi-Kolkata', 'SLEEPER', 18, 1500, NULL, NULL, NULL, 'E0047'),
    ('TRAIN', 'T007B', 800, 'Delhi-Kolkata', '3 TIER', 18, NULL, 2500, NULL, NULL, 'E0047'),
    ('TRAIN', 'T007C', 800, 'Delhi-Kolkata', '2 TIER', 18, NULL, NULL, 3000, NULL, 'E0047'),
    ('TRAIN', 'T007D', 800, 'Delhi-Kolkata', '1 CLASS', 18, NULL, NULL, NULL, 4850, 'E0047'),

    ('TRAIN', 'T008A', 800, 'Mumbai-Chennai', 'SLEEPER', 24, 1700, NULL, NULL, NULL, 'E0048'),
    ('TRAIN', 'T008B', 800, 'Mumbai-Chennai', '3 TIER', 24, NULL, 2860, NULL, NULL, 'E0048'),
    ('TRAIN', 'T008C', 800, 'Mumbai-Chennai', '2 TIER', 24, NULL, NULL, 3500, NULL, 'E0048'),
    ('TRAIN', 'T008D', 800, 'Mumbai-Chennai', '1 CLASS', 24, NULL, NULL, NULL, 5500, 'E0048'),

    ('TRAIN', 'T009A', 800, 'Ahmedabad-Delhi', 'SLEEPER', 15, 1300, NULL, NULL, NULL, 'E0049'),
    ('TRAIN', 'T009B', 800, 'Ahmedabad-Delhi', '3 TIER', 15, NULL, 2000, NULL, NULL, 'E0049'),
    ('TRAIN', 'T009C', 800, 'Ahmedabad-Delhi', '2 TIER', 15, NULL, NULL, 2900, NULL, 'E0049'),
    ('TRAIN', 'T009D', 800, 'Ahmedabad-Delhi', '1 CLASS', 15, NULL, NULL, NULL, 3980, 'E0049'),

    ('TRAIN', 'T010A', 800, 'Pune-Bangalore', 'SLEEPER', 18, 1200, NULL, NULL, NULL, 'E0050'),
    ('TRAIN', 'T010B', 800, 'Pune-Bangalore', '3 TIER', 18, NULL, 2400, NULL, NULL, 'E0050'),
    ('TRAIN', 'T010C', 800, 'Pune-Bangalore', '2 TIER', 18, NULL, NULL, 3500, NULL, 'E0050'),
    ('TRAIN', 'T010D', 800, 'Pune-Bangalore', '1 CLASS', 18, NULL, NULL, NULL, 4800, 'E0050'),

    ('TRAIN', 'T011A', 800, 'Jaipur-Varanasi', 'SLEEPER', 20, 1800, NULL, NULL, NULL, 'E0051'),
    ('TRAIN', 'T011B', 800, 'Jaipur-Varanasi', '3 TIER', 20, NULL, 2100, NULL, NULL, 'E0051'),
    ('TRAIN', 'T011C', 800, 'Jaipur-Varanasi', '2 TIER', 20, NULL, NULL, 2900, NULL, 'E0051'),
    ('TRAIN', 'T011D', 800, 'Jaipur-Varanasi', '1 CLASS', 20, NULL, NULL, NULL, 4000, 'E0051'),

    ('TRAIN', 'T012A', 800, 'Kolkata-Mumbai', 'SLEEPER', 24, 2000, NULL, NULL, NULL, 'E0052'),
    ('TRAIN', 'T012B', 800, 'Kolkata-Mumbai', '3 TIER', 24, NULL, 2900, NULL, NULL, 'E0052'),
    ('TRAIN', 'T012C', 800, 'Kolkata-Mumbai', '2 TIER', 24, NULL, NULL, 3560, NULL, 'E0052'),
    ('TRAIN', 'T012D', 800, 'Kolkata-Mumbai', '1 CLASS', 24, NULL, NULL, NULL, 4900, 'E0052'),

    ('TRAIN', 'T013A', 800, 'Delhi-Amritsar', 'SLEEPER', 6, 700, NULL, NULL, NULL, 'E0053'),
    ('TRAIN', 'T013B', 800, 'Delhi-Amritsar', '3 TIER', 6, NULL, 1500, NULL, NULL, 'E0053'),
    ('TRAIN', 'T013C', 800, 'Delhi-Amritsar', '2 TIER', 6, NULL, NULL, 2400, NULL, 'E0053'),
    ('TRAIN', 'T013D', 800, 'Delhi-Amritsar', '1 CLASS', 6, NULL, NULL, NULL, 3980, 'E0053'),

    ('TRAIN', 'T014A', 800, 'Hyderabad-Chennai', 'SLEEPER', 12, 1100, NULL, NULL, NULL, 'E0054'),
    ('TRAIN', 'T014B', 800, 'Hyderabad-Chennai', '3 TIER', 12, NULL, 2000, NULL, NULL, 'E0054'),
    ('TRAIN', 'T014C', 800, 'Hyderabad-Chennai', '2 TIER', 12, NULL, NULL, 3000, NULL, 'E0054'),
    ('TRAIN', 'T014D', 800, 'Hyderabad-Chennai', '1 CLASS', 12, NULL, NULL, NULL, 4100, 'E0054'),

    ('TRAIN', 'T021A', 800, 'Chennai-Kochi', 'SLEEPER', 8, 900, NULL, NULL, NULL, 'E0055'),
    ('TRAIN', 'T021B', 800, 'Chennai-Kochi', '3 TIER', 8, NULL, 1300, NULL, NULL, 'E0055'),
    ('TRAIN', 'T021C', 800, 'Chennai-Kochi', '2 TIER', 8, NULL, NULL, 1800, NULL, 'E0055'),
    ('TRAIN', 'T021D', 800, 'Chennai-Kochi', '1 CLASS', 8, NULL, NULL, NULL, 2850, 'E0055'),
    
    ('TRAIN', 'T015A', 800, 'Hyderabad-Delhi', 'SLEEPER', 26, 1900, NULL, NULL, NULL, 'E0051'),
    ('TRAIN', 'T015B', 800, 'Hyderabad-Delhi', '3 TIER', 26, NULL, 2980, NULL, NULL, 'E0051'),
    ('TRAIN', 'T015C', 800, 'Hyderabad-Delhi', '2 TIER', 26, NULL, NULL, 3900, NULL, 'E0051'),
    ('TRAIN', 'T015D', 800, 'Hyderabad-Delhi', '1 CLASS', 26, NULL, NULL, NULL, 4975, 'E0051'),

    ('TRAIN', 'T016A', 800, 'Chennai-Delhi', 'SLEEPER', 30, 2000, NULL, NULL, NULL, 'E0052'),
    ('TRAIN', 'T016B', 800, 'Chennai-Delhi', '3 TIER', 30, NULL, 3200, NULL, NULL, 'E0052'),
    ('TRAIN', 'T016C', 800, 'Chennai-Delhi', '2 TIER', 30, NULL, NULL, 4600, NULL, 'E0052'),
    ('TRAIN', 'T016D', 800, 'Chennai-Delhi', '1 CLASS', 30, NULL, NULL, NULL, 5500, 'E0052'),

    ('TRAIN', 'T017A', 800, 'Bangalore-Kolkata', 'SLEEPER', 36, 2100, NULL, NULL, NULL, 'E0053'),
    ('TRAIN', 'T017B', 800, 'Bangalore-Kolkata', '3 TIER', 36, NULL, 3300, NULL, NULL, 'E0053'),
    ('TRAIN', 'T017C', 800, 'Bangalore-Kolkata', '2 TIER', 36, NULL, NULL, 4000, NULL, 'E0053'),
    ('TRAIN', 'T017D', 800, 'Bangalore-Kolkata', '1 CLASS', 36, NULL, NULL, NULL, 6590, 'E0053'),

    ('TRAIN', 'T018A', 800, 'Delhi-Jammu', 'SLEEPER', 12, 1000, NULL, NULL, NULL, 'E0054'),
    ('TRAIN', 'T018B', 800, 'Delhi-Jammu', '3 TIER', 12, NULL, 1890, NULL, NULL, 'E0054'),
    ('TRAIN', 'T018C', 800, 'Delhi-Jammu', '2 TIER', 12, NULL, NULL, 2460, NULL, 'E0054'),
    ('TRAIN', 'T018D', 800, 'Delhi-Jammu', '1 CLASS', 12, NULL, NULL, NULL, 3280, 'E0054'),

    ('TRAIN', 'T019A', 800, 'Pune-Varanasi', 'SLEEPER', 22, 1600, NULL, NULL, NULL, 'E0055'),
    ('TRAIN', 'T019B', 800, 'Pune-Varanasi', '3 TIER', 22, NULL, 2500, NULL, NULL, 'E0055'),
    ('TRAIN', 'T019C', 800, 'Pune-Varanasi', '2 TIER', 22, NULL, NULL, 3500, NULL, 'E0055'),
    ('TRAIN', 'T019D', 800, 'Pune-Varanasi', '1 CLASS', 22, NULL, NULL, NULL, 4600, 'E0055'),

    ('TRAIN', 'T020A', 800, 'Kolkata-Silchar', 'SLEEPER', 36, 2200, NULL, NULL, NULL, 'E0056'),
    ('TRAIN', 'T020B', 800, 'Kolkata-Silchar', '3 TIER', 36, NULL, 2990, NULL, NULL, 'E0056'),
    ('TRAIN', 'T020C', 800, 'Kolkata-Silchar', '2 TIER', 36, NULL, NULL, 3990, NULL, 'E0056'),
    ('TRAIN', 'T020D', 800, 'Kolkata-Silchar', '1 CLASS', 36, NULL, NULL, NULL, 4950, 'E0056');

INSERT INTO planeRoute
	(modeType, planeNo, totalCapacity, route, travelMode, travelDuration, fareEconomy, fareFirstClass, farePrivate, empId)
VALUES
('PLANE', 'P015A', 800, 'Hyderabad-Delhi', 'ECONOMY', 2, 2500, NULL, NULL, 'E0060'),
('PLANE', 'P015B', 800, 'Hyderabad-Delhi', 'FIRST CLASS', 2, NULL, 5000, NULL, 'E0060'),
('PLANE', 'P015C', 800, 'Hyderabad-Delhi', 'PRIVATE', 2, NULL, NULL, 10000, 'E0060'),

('PLANE', 'P016A', 800, 'Chennai-Delhi', 'ECONOMY', 3, 3000, NULL, NULL, 'E0061'), 
('PLANE', 'P016B', 800, 'Chennai-Delhi', 'FIRST CLASS', 3, NULL, 6000, NULL, 'E0061'),
('PLANE', 'P016C', 800, 'Chennai-Delhi', 'PRIVATE', 3, NULL, NULL, 12000, 'E0061'),

('PLANE', 'P017A', 800, 'Bangalore-Kolkata', 'ECONOMY', 3, 2500, NULL, NULL, 'E0062'), 
('PLANE', 'P017B', 800, 'Bangalore-Kolkata', 'FIRST CLASS', 3, NULL, 5500, NULL, 'E0062'),
('PLANE', 'P017C', 800, 'Bangalore-Kolkata', 'PRIVATE', 3, NULL, NULL, 11500, 'E0062'),

('PLANE', 'P018A', 800, 'Delhi-Jammu', 'ECONOMY', 1, 1500, NULL, NULL, 'E0063'), 
('PLANE', 'P018B', 800, 'Delhi-Jammu', 'FIRST CLASS', 1, NULL, 3500, NULL, 'E0063'),
('PLANE', 'P018C', 800, 'Delhi-Jammu', 'PRIVATE', 1, NULL, NULL, 7000, 'E0063'),

('PLANE', 'P019A', 800, 'Pune-Varanasi', 'ECONOMY', 2, 2000, NULL, NULL, 'E0064'),  
('PLANE', 'P019B', 800, 'Pune-Varanasi', 'FIRST CLASS', 2, NULL, 4500, NULL, 'E0064'),
('PLANE', 'P019C', 800, 'Pune-Varanasi', 'PRIVATE', 2, NULL, NULL, 9500, 'E0064'),

('PLANE', 'P020A', 800, 'Kolkata-Silchar', 'ECONOMY', 4, 3200, NULL, NULL, 'E0065'),  -- 200 minutes = 3.5 hours
('PLANE', 'P020B', 800, 'Kolkata-Silchar', 'FIRST CLASS', 4, NULL, 7000, NULL, 'E0065'),
('PLANE', 'P020C', 800, 'Kolkata-Silchar', 'PRIVATE', 4, NULL, NULL, 15000, 'E0065'),

('PLANE', 'P021A', 800, 'Mumbai-Delhi', 'ECONOMY', 2, 2000, NULL, NULL, 'E0066'),  -- 90 minutes = 1.5 hours
('PLANE', 'P021B', 800, 'Mumbai-Delhi', 'FIRST CLASS', 2, NULL, 4500, NULL, 'E0066'),
('PLANE', 'P021C', 800, 'Mumbai-Delhi', 'PRIVATE', 2, NULL, NULL, 9000, 'E0066'),

('PLANE', 'P022A', 800, 'Delhi-Varanasi', 'ECONOMY', 2, 2200, NULL, NULL, 'E0067'),  -- 100 minutes = 1.5 hours
('PLANE', 'P022B', 800, 'Delhi-Varanasi', 'FIRST CLASS', 2, NULL, 4800, NULL, 'E0067'),
('PLANE', 'P022C', 800, 'Delhi-Varanasi', 'PRIVATE', 2, NULL, NULL, 9500, 'E0067'),

('PLANE', 'P023A', 800, 'Pune-Mumbai', 'ECONOMY', 1, 1500, NULL, NULL, 'E0068'),  -- 75 minutes = 1.25 hours
('PLANE', 'P023B', 800, 'Pune-Mumbai', 'FIRST CLASS', 1, NULL, 3500, NULL, 'E0068'),
('PLANE', 'P023C', 800, 'Pune-Mumbai', 'PRIVATE', 1, NULL, NULL, 8000, 'E0068');

-- CREATE VIEW uniqueViews AS
-- SELECT DISTINCT route
-- FROM trainRoute;
-- SELECT * FROM uniqueViews;


-- View data in tables
SELECT * FROM busRoute;
SELECT * FROM cabRoute;
SELECT * FROM trainRoute;
SELECT * FROM planeRoute;
SELECT * FROM companyEmployee;

-- now we will be entering the commands for Arithmetic and Logical Commands
SELECT max(fareAC) as MaximumPriceBus
FROM busRoute; -- this should show maximum price=500

SELECT avg(fareAc) as avgPricesACBus
from busRoute; -- this should show (500+450)/2 as per the data in the TABLE

SELECT count(busNo) as TotalBuses
FROM busRoute; -- this should show 4

SELECT -- THIS IS CODE FOR UNION OF ROUTE PRICES DIFF MODES
route,
    modeType,
    travelMode,
    fareAC as travelFare
FROM
busRoute
WHERE
route="Mumbai-Pune"
   
UNION ALL

SELECT
route,
    modeType,
    carModel as travelMode,
CASE
WHEN carModel="MINI" THEN  fareMini
    WHEN carModel="PRIME" THEN farePrime
    WHEN carModel="SUV" THEN fareSUV
    END AS travelFare
FROM
cabRoute
WHERE
route="Mumbai-Pune";


SELECT busNo, route, travelType 
FROM busRoute 
WHERE route IN ('Mumbai-Pune');

SELECT cabNo, route, carModel 
FROM cabRoute 
WHERE route IN ('Mumbai-Pune');

SELECT empName, empId 
FROM companyEmployee 
WHERE empId NOT IN (
    SELECT empId 
    FROM busRoute 
    WHERE busNo IN ('1000', '1001')
);

-- Some QUERIES for Equi-Join and all that
SELECT busRoute.busNo, busRoute.route, companyEmployee.empName
FROM busRoute
INNER JOIN companyEmployee
ON busRoute.empId = companyEmployee.empId;

SELECT busRoute.busNo, cabRoute.cabNo
FROM busRoute
CROSS JOIN cabRoute;

SELECT e1.empName AS Employee1, e2.empName AS Employee2
FROM companyEmployee e1
JOIN companyEmployee e2
ON e1.empId < e2.empId;

SELECT busRoute.busNo, busRoute.route, companyEmployee.empName
FROM busRoute
LEFT JOIN companyEmployee
ON busRoute.empId = companyEmployee.empId;

SELECT busRoute.busNo, cabRoute.cabNo, busRoute.fareAC, cabRoute.fareMini
FROM busRoute, cabRoute
WHERE busRoute.fareAC > cabRoute.fareMini;

SELECT empId, empName, 'Bus Driver' AS Role
FROM companyEmployee
LEFT JOIN busRoute ON companyEmployee.empId = busRoute.empId
WHERE busRoute.empId IS NOT NULL

UNION

SELECT empId, empName, 'Cab Driver' AS Role
FROM companyEmployee
LEFT JOIN cabRoute ON companyEmployee.empId = cabRoute.empId
WHERE cabRoute.empId IS NOT NULL;

SELECT route
FROM busRoute

UNION

SELECT route
FROM cabRoute;

SELECT busRoute.route
FROM busRoute
INNER JOIN cabRoute
ON busRoute.route = cabRoute.route;
