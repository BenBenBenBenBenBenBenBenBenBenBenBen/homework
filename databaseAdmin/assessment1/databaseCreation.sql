CREATE DATABASE IF NOT EXISTS Referrals;
USE Referrals;

CREATE TABLE IF NOT EXISTS Patient(
	NHI VARCHAR(7) NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    DOB DATE NOT NULL,
    Primary Key (NHI)
);

LOAD DATA INFILE 'C:/Temp/mysql/patient.csv'
INTO TABLE Patient
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

CREATE TABLE IF NOT EXISTS Department (
	department VARCHAR(20) NOT NULL,
    PRIMARY KEY (department)
);

LOAD DATA INFILE 'C:/Temp/mysql/department.csv'
INTO TABLE Department
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

CREATE TABLE IF NOT EXISTS Surgeon(
	surgeonID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    department VARCHAR(20),
    Primary Key (surgeonID),
    FOREIGN KEY (department) REFERENCES Department(department)
);

LOAD DATA INFILE 'C:/Temp/mysql/surgeon.csv'
INTO TABLE Surgeon
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

CREATE TABLE IF NOT EXISTS Referrer (
	referrerID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    PRIMARY KEY (referrerID)
);

LOAD DATA INFILE 'C:/Temp/mysql/referrer.csv'
INTO TABLE Referrer
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

CREATE TABLE IF NOT EXISTS HealthTargetEligible (
	healthTargetEligible VARCHAR(3) NOT NULL,
    PRIMARY KEY (healthTargetEligible)
);

LOAD DATA INFILE 'C:/Temp/mysql/healthTargetEligible.csv'
INTO TABLE HealthTargetEligible
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

CREATE TABLE IF NOT EXISTS Referral(
	referralID int NOT NULL AUTO_INCREMENT,
    referralDate DATE NOT NULL,
    dateAddedToWaitList DATE,
    FSADate DATE,
    healthTargetEligible VARCHAR(3),
    referrerID INT,
    patientID VARCHAR(7) NOT NULL,
    surgeonID INT NOT NULL,
    Primary Key (referralID),
    CONSTRAINT FK_Referrer FOREIGN KEY (referrerID) REFERENCES Referrer(referrerID),
    CONSTRAINT FK_HealthTargetEligible FOREIGN KEY (healthTargetEligible) REFERENCES HealthTargetEligible(healthTargetEligible),
    CONSTRAINT FK_patient FOREIGN KEY (patientID) REFERENCES Patient(NHI),
    CONSTRAINT FK_Surgeon FOREIGN KEY (surgeonID) REFERENCES Surgeon(surgeonID)
);

LOAD DATA INFILE 'C:/Temp/mysql/referral.csv'
INTO TABLE Referral
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;