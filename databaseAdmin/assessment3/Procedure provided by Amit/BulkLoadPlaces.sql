USE [Vaccinations]
GO

-- Create the procedure
CREATE PROCEDURE [bulkLoadPlaces] 
	-- Loads a file of places into the Place table.  No error checking.
	@fileName varchar(100) = ''	-- The file name where the data is being loaded from
AS
BEGIN
	DECLARE @sqlString varchar(512) = '' -- The string that is being executed to bulk load the data
	
	--  Create the temporary table to load the data by copying the structure
	DROP TABLE IF EXISTS #newPlaces
	SELECT TOP 0 * INTO #newPlaces FROM Place

	-- Create and execute the sql string.  The quotes are important
	SET @sqlString = '
	BULK INSERT #newPlaces
	FROM '''  + @fileName + '''
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = '','',
		ROWTERMINATOR=''\n''
	)'
	EXECUTE (@sqlString)

	-- Use a cursor to loop through the temporary table, and load the data into the permanent table
	-- Variables data read from
	DECLARE @placeId char(10)
	DECLARE @longName nvarchar(50)
	DECLARE @maxSlots tinyint

	-- the cursor declared 
	DECLARE newPlacesCursor CURSOR FOR
		SELECT id FROM #newPlaces
		-- Open Cursor
	OPEN newPlacesCursor
	
	-- Loop through the cursor until there is no more data
	FETCH NEXT FROM newPlacesCursor INTO @placeId
	-- We have not started fetching yet!!
	WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Get the data from the temporary table
			SELECT @longName = longName, @maxSlots = maxSlots
				FROM #newPlaces
				WHERE id = @placeId
			-- Run the procedure that enters the data
			EXEC createPlace @id=@placeId, @longName=@longname, @maxSlots=@maxSlots
			-- Get the next lot of data
			FETCH NEXT FROM newPlacesCursor INTO @placeId
		END

	-- Tidy up
	CLOSE newPlacesCursor -- close the cursor
	DEALLOCATE newPlacesCursor -- Free up the memory
	DROP TABLE #newPlaces -- Purge the Temp Table
END 
GO
-- Testing data
--DELETE FROM Place
--SELECT * FROM Place
--EXEC bulkLoadVaccinators @fileName = 'C:\Temp\Vaccine2023Data\Sites.csv'
--SELECT * FROM Place