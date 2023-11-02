USE Vaccinations;

GO

CREATE OR ALTER VIEW totalVacinations AS
	SELECT a.placeId, CONVERT(DATE, a.apptTime) AS appointment_day, COUNT(a.Slot) AS numberOfPossibleVaccine, COUNT(CASE WHEN personId IS NOT NULL THEN 1 ELSE NULL END) AS actualNumberOfVaccines FROM Appointment a
		GROUP By a.placeId, CONVERT(DATE, a.apptTime);

GO

CREATE OR ALTER VIEW VaccinatedPeopleByAgeDecades AS
SELECT
    FLOOR(DATEDIFF(YEAR, p.dateOfBirth, a.apptTime) / 10) * 10 AS ageDecadeCategory,
    p.NHI AS PatientNHI,
    p.preferredName AS PatientName,
    a.vialNumber AS firstVaccineVial,
    a.apptTime AS firstVaccineTime,
    DATEDIFF(YEAR, p.dateOfBirth, a.apptTime) AS ageAtFirstVaccine
FROM [Person] p
INNER JOIN [Appointment] a ON p.NHI = a.personId
WHERE a.personId IS NOT NULL;

GO

CREATE OR ALTER VIEW VaccinatorStatistics AS
SELECT
    v.[iRDNumber] AS vaccinatorIRD,
    v.[preferredName] AS vaccinatorName,
    COUNT(DISTINCT CAST(a.[apptTime] AS DATE)) AS numberOfSessions,
    COUNT(a.[id]) AS numberOfVaccines
FROM [Vaccinations].[dbo].[Vaccinator] v
LEFT JOIN [Vaccinations].[dbo].[Appointment] a ON v.[iRDNumber] = a.[vaccinator]
GROUP BY v.[iRDNumber], v.[preferredName];
