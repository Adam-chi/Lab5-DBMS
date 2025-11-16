create database lab3;
 use lab3;

 CREATE TABLE Patient (
 IID INT PRIMARY KEY,
 CIN VARCHAR(10) UNIQUE NOT NULL,
 FullName VARCHAR(100) NOT NULL,
 Birth DATE,
 Sex ENUM('M', 'F') NOT NULL,
 BloodGroup ENUM('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+',
 'AB-'),
 Phone VARCHAR(15)
 );
 CREATE TABLE Hospital (
 HID INT PRIMARY KEY,
 Name VARCHAR(100) NOT NULL,
 City VARCHAR(50) NOT NULL,
 Region VARCHAR(50)
 );
 CREATE TABLE Department (
 DEP_ID INT,
 HID INT,
 Name VARCHAR(100) NOT NULL,
 Specialty VARCHAR(100),
 PRIMARY KEY ( DEP_ID),
 FOREIGN KEY (HID) REFERENCES Hospital(HID)
 );
 CREATE TABLE Staff (
 STAFF_ID INT PRIMARY KEY,
 FullName VARCHAR(100) NOT NULL,
 Status ENUM('Active','Retired') DEFAULT 'Active'
 );
 CREATE TABLE Work_in (
 STAFF_ID INT ,
 Dep_ID INT ,
 primary key(STAFF_ID,Dep_ID),
 FOREIGN KEY ( STAFF_ID ) REFERENCES Staff(STAFF_ID),
 FOREIGN KEY ( Dep_ID ) REFERENCES Department(DEP_ID)
 );
 CREATE TABLE ClinicalActivity (

CAID INT PRIMARY KEY,
 IID INT NOT NULL,
 STAFF_ID INT NOT NULL,
 DEP_ID INT NOT NULL,
 Date DATE NOT NULL,
 Time TIME,
 FOREIGN KEY (IID) REFERENCES Patient(IID),
 FOREIGN KEY (STAFF_ID) REFERENCES Staff(STAFF_ID),
 FOREIGN KEY (DEP_ID) REFERENCES Department(DEP_ID)
 );
 CREATE TABLE Appointment (
 CAID INT PRIMARY KEY,
 Reason VARCHAR(100),
 Status ENUM('Scheduled','Completed','Cancelled') DEFAULT
 'Scheduled',
 FOREIGN KEY (CAID) REFERENCES ClinicalActivity(CAID)
 );
 CREATE TABLE Emergency (
 CAID INT PRIMARY KEY,
 TriageLevel INT CHECK (TriageLevel BETWEEN 1 AND 5),
 Outcome ENUM('Discharged','Admitted','Transferred','Deceased'),
 FOREIGN KEY (CAID) REFERENCES ClinicalActivity(CAID)
 );
 CREATE TABLE Insurance (
 InsID INT PRIMARY KEY,
 Type ENUM('CNOPS','CNSS','RAMED','Private','None') NOT NULL
 );
 CREATE TABLE Expense (
 ExpID INT PRIMARY KEY,
 InsID INT,
 CAID INT UNIQUE NOT NULL,
 Total DECIMAL(10,2) NOT NULL CHECK (Total >= 0),
 FOREIGN KEY (InsID) REFERENCES Insurance(InsID),
 FOREIGN KEY (CAID) REFERENCES ClinicalActivity(CAID)
 );
 CREATE TABLE Medication (
 MID INT PRIMARY KEY,
 Name VARCHAR(100) NOT NULL,
 Form VARCHAR(50),
 Strength VARCHAR(50),
 ActiveIngredient VARCHAR(100),
 TherapeuticClass VARCHAR(100),
 Manufacturer VARCHAR(100)
 );
 CREATE TABLE Stock (
 HID INT,
 MID INT,
 StockTimestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
 UnitPrice DECIMAL(10,2) CHECK (UnitPrice >= 0),
 Qty INT DEFAULT 0 CHECK (Qty >= 0),
ReorderLevel INT DEFAULT 10 CHECK (ReorderLevel >= 0),
 PRIMARY KEY (HID, MID, StockTimestamp),
 FOREIGN KEY (HID) REFERENCES Hospital(HID),
 FOREIGN KEY (MID) REFERENCES Medication(MID)
 );
 CREATE TABLE Prescription (
 PID INT PRIMARY KEY,
 CAID INT UNIQUE NOT NULL,
 DateIssued DATE NOT NULL,
 FOREIGN KEY (CAID) REFERENCES ClinicalActivity(CAID)
 );
 CREATE TABLE Includes (
 PID INT,
 MID INT,
 Dosage VARCHAR(100),
 Duration VARCHAR(50),
 PRIMARY KEY (PID, MID),
 FOREIGN KEY (PID) REFERENCES Prescription(PID),
 FOREIGN KEY (MID) REFERENCES Medication(MID)
 );
 CREATE TABLE ContactLocation (
 CLID INT PRIMARY KEY,
 City VARCHAR(50),
 Province VARCHAR(50),
 Street VARCHAR(100),
 Number VARCHAR(10),
 PostalCode VARCHAR(10),
 Phone_Location VARCHAR(15)
 );
 CREATE TABLE have (
 IID INT,
 CLID INT,
 PRIMARY KEY (IID, CLID),
 FOREIGN KEY (IID) REFERENCES Patient(IID),
 FOREIGN KEY (CLID) REFERENCES ContactLocation(CLID)
 );