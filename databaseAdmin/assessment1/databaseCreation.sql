CREATE DATABASE IF NOT EXISTS Referrals;
USE Referrals;
CREATE TABLE IF NOT EXISTS Gender (
	gender VARCHAR(6) NOT NULL,
    PRIMARY KEY (Gender)
);

CREATE TABLE IF NOT EXISTS Patient(
	NHI VARCHAR(7) NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    DOB DATE NOT NULL,
    gender VARCHAR(6) NOT NULL,
    age TINYINT,
    Primary Key (NHI),
    FOREIGN KEY (Gender) REFERENCES Gender(gender)
);

UPDATE Patient
SET age = TIMESTAMPDIFF(YEAR, DOB, CURDATE()) -
	(DATE_FORMAT(CURDATE(), '%m%d') < DATE_FORMAT(DOB, '%m%d'));

CREATE TABLE IF NOT EXISTS Department (
	department VARCHAR(20) NOT NULL,
    PRIMARY KEY (department)
);

CREATE TABLE IF NOT EXISTS Surgeon(
	SurgeonID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    department VARCHAR(20),
    Primary Key (SurgeonID),
    FOREIGN KEY (department) REFERENCES Department(department)
);

CREATE TABLE IF NOT EXISTS Referrer (
	ReferrerID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    PRIMARY KEY (ReferrerID)
);

CREATE TABLE IF NOT EXISTS ReferredFrom (
	referredFrom VARCHAR(20) NOT NULL,
    PRIMARY KEY (referredFrom)
);

CREATE TABLE IF NOT EXISTS HealthTargetEligible (
	healthTargetEligible VARCHAR(3) NOT NULL,
    PRIMARY KEY (healthTargetEligible)
);

CREATE TABLE IF NOT EXISTS Referral(
	referralID int NOT NULL AUTO_INCREMENT,
    referralDate DATE NOT NULL,
    referredFrom VARCHAR(20),
    ReferrerID INT,
    dateAddedToWaitList DATE NOT NULL,
    FSADate DATE,
    healthTargetEligible VARCHAR(3),
    surgeonID INT NOT NULL,
    patientID VARCHAR(7) NOT NULL,
    daysWaitingFromReferralDate int,
    Primary Key (referralID),
    CONSTRAINT FK_ReferredFrom FOREIGN KEY (referredFrom) REFERENCES ReferredFrom(referredFrom),
    CONSTRAINT FK_Referrer FOREIGN KEY (ReferrerID) REFERENCES Referrer(ReferrerID),
    CONSTRAINT FK_HealthTargetEligible FOREIGN KEY (healthTargetEligible) REFERENCES HealthTargetEligible(healthTargetEligible),
    CONSTRAINT FK_Surgeon FOREIGN KEY (surgeonID) REFERENCES Surgeon(surgeonID),
    CONSTRAINT FK_patient FOREIGN KEY (patientID) REFERENCES Patient(NHI)
);

UPDATE Referral
SET daysWaitingFromReferralDate = TIMESTAMPDIFF(DAY, referralDate, FSADate) -
	(DATE_FORMAT(FSADate, '%m%d') < DATE_FORMAT(referralDate, '%m%d'));