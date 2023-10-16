USE Vaccinations

DROP PROCEDURE IF EXISTS bulkAddPeopleToAppointments
GO

CREATE PROCEDURE bulkAddPeopleToAppointments
	@startSlot int, 
	@endSlot int
AS
BEGIN
	DECLARE @slotNumber int
	SET @slotNumber = @startSlot
	DECLARE @personID char(10) = NULL

	WHILE @slotNumber <= @endSlot
	BEGIN
		-- Might skip this slot
		IF RAND() > 0.1 --90% coverage
		BEGIN
		-- Find a random new person
			SET @personId = NULL
			WHILE @personID IS NULL
			BEGIN
				SET @personID = (SELECT TOP 1 NHI FROM AllPeople ORDER BY NEWID())	-- A random perosn from the poeulation
				IF (SELECT COUNT(NHI) FROM Person WHERE NHI=@personId) = 1 -- Person already exists
				BEGIN
					SET @personID = NULL
				END
			END
			EXEC addPersonToAppointment @id=@slotNumber, @personId=@personId, @vaccineNumber=1
		END
		SET @slotNumber = @slotNumber + 1
	END
END
GO

-- Test
--EXEC bulkAddPeopleToAppointments @startSlot=1500, @endSlot=5800
-- Check duplicates
-- select personId, count(personId) AS PersonCount from appointment GROUP BY personId having count(personId)>1

