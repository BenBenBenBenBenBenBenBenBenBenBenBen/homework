USE Vaccinations;

GO
-- View 1: totalVaccinations
-- This view calculates the total number of appointments, appointment days, and actual vaccines administered for each vaccination place.
CREATE OR ALTER VIEW totalVaccinations AS
	SELECT placeId, CONVERT(DATE, apptTime) AS appointment_day, COUNT(*) AS slot_count, COUNT(CASE WHEN personId IS NOT NULL THEN 1 ELSE NULL END) AS actualNumberOfVaccines
	FROM appointment
	GROUP BY placeid, CONVERT(DATE, apptTime);
GO
--Test
SELECT * FROM totalVaccinations
GO
-- View 2: MissedAppointments
-- This view retrieves information about missed appointments, including person details.
CREATE Or ALTER VIEW MissedAppointments AS
	SELECT op.personId, p.preferredName, p.eMail, p.phone, p.preferredContactMethod
	FROM OldAppointment op
		INNER JOIN Person p 
			ON op.personId = p.NHI
		WHERE op.missed=1;
GO
--Test
SELECT * FROM MissedAppointments
GO
-- View 3: VaccinatedPeopleByAgeDecades
-- This view categorizes vaccinated people into age decades and provides details about their vaccination history.
CREATE OR ALTER VIEW VaccinatedPeopleByAgeDecades AS
	SELECT FLOOR(DATEDIFF(YEAR, p.dateOfBirth, a.apptTime) / 10) * 10 AS ageDecadeCategory, p.NHI AS PatientNHI, p.preferredName AS PatientName,
		a.vialNumber AS firstVaccineVial, a.apptTime AS firstVaccineTime, DATEDIFF(YEAR, p.dateOfBirth, a.apptTime) AS ageAtFirstVaccine
	FROM Person p
	INNER JOIN Appointment a ON p.NHI = a.personId
	WHERE a.personId IS NOT NULL;
GO
--Test
SELECT * FROM VaccinatedPeopleByAgeDecades
GO
-- View 4: vaccinatorStatistics
-- This view provides statistics on vaccinators, including the number of sessions and vaccines administered by each vaccinator.
CREATE OR ALTER VIEW vaccinatorStatistics AS
	SELECT v.iRDNumber AS vaccinatorIRD, v.preferredName AS vaccinatorName, COUNT(DISTINCT CAST(a.apptTime AS DATE)) AS numberOfSessions, COUNT(a.id) AS numberOfVaccines
	FROM Vaccinations.dbo.Vaccinator v
		LEFT JOIN Vaccinations.dbo.Appointment a ON v.iRDNumber = a.vaccinator
		GROUP BY v.iRDNumber, v.preferredName;
GO
--Test
SELECT * FROM vaccinatorStatistics