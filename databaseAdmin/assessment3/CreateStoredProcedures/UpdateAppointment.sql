USE Vaccinations

DROP PROCEDURE IF EXISTS addPersonToAppointment
GO

CREATE PROCEDURE addPersonToAppointment
	@id int, 
	@personId char(10) = NULL,
	@vaccineNumber tinyint = 1
AS
BEGIN
	DECLARE @NHI char(10) = NULL
	-- Check if person in Person table already, and if not, add them to it
	SET @NHI = (SELECT NHI FROM Person WHERE NHI=@personId)
	IF @NHI IS NULL
	BEGIN
		-- There is a population table of people called AllPeople
		INSERT INTO Person SELECT * FROM AllPeople WHERE NHI=@personId
	END
	IF (SELECT COUNT(NHI) FROM Person WHERE NHI=@personId) = 1 -- Just in case teh person wasn;t part of teh population
	BEGIN
		UPDATE Appointment
		SET personId = @personId, vaccineNumber = @vaccineNumber
			WHERE id=@id
	END
END
GO

-- Test
-- 
--EXEC addPersonToAppointment @id=1437, @personId='AAY0020', @vaccineNumber=1
--SELECT * FROM Appointment WHERE personID IS NOT NULL




