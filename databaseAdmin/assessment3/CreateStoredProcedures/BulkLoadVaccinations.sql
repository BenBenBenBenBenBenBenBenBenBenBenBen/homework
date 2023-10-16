-- Choose the data base, delete teh previous procedure if it is there
USE Vaccinations
GO
DROP PROCEDURE IF EXISTS bulkLoadVaccinations
GO

-- Create the procedure
CREATE PROCEDURE bulkLoadVaccinations 
	-- Loads a file of appointments into the Appointment table.  No error checking.
	@fileName varchar(100) = '',	-- The file naem where the data is being loaded from
	@startApptNumber int,			-- Start and end slot to load the data
	@endApptNumber int
AS
BEGIN
	DECLARE @sqlString varchar(512) = '' -- The string that is being executed to bulk load the data
	
	--  Create the temporary table to load teh vaccinators into
	DROP TABLE IF EXISTS #vaccinatorPreferred
	CREATE TABLE #vaccinatorPreferred (
		placeId char(10),			-- The place
		slot tinyint,				-- The slot
		vaccinator char(10)			-- the vaccinator
	)

	-- Create and execute teh sql string to load teh vaccinators.  The quotes are important
	SET @sqlString = '
	BULK INSERT #vaccinatorPreferred
	FROM '''  + @fileName + '''
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = '','',
		ROWTERMINATOR=''\n''
	)'
	EXECUTE (@sqlString)

	-- Loop through the appointments and assign the vaccinator and the vial
	-- 95% coverage in this case

	DECLARE @apptNumber int=NULL
	SET @apptNumber = @startApptNumber
	DECLARE @person char(12) = NULL
	DECLARE @vaccinator char(10) = NULL
	DECLARE @slotNumber tinyint = NULL
	DECLARE @place char(10) = NULL
	DECLARE @vialNumber char(15) = NULL

	WHILE @apptNumber <= @endApptNumber
	BEGIN
		SELECT @person=personId, @place=placeId, @slotNumber=slot FROM Appointment WHERE id = @apptNumber
		IF ((@person IS NOT NULL) AND (rand()<.95))
		BEGIN
			-- Vaccinate teh person
			SET @vaccinator = (SELECT vaccinator FROM #vaccinatorPreferred WHERE placeId=@place AND slot=@slotNumber)
			SET @vialNumber = CONCAT('SC',FORMAT(@apptNumber,'0000000')) -- need a number for testing
			EXEC vaccinatePerson @id=@apptNumber,@vaccinatorId=@vaccinator,@vialNumber=@vialNumber
		END 
		SET @apptNumber = @apptNumber + 1
	END

	-- Tidy up
	DROP TABLE #vaccinatorPreferred
END 
GO


-- Testing data
GO
--EXEC bulkLoadVaccinations @fileName = 'C:\Temp\Vaccines2021\SitesVaccinators.csv',@startApptNumber=1500,@endApptNumber=5584
GO
--SELECT max(id) FROM Appointment WHERE apptTime <'2021-08-27 00:00:00'
select * from appointment where id > 5580 and id < 5590


