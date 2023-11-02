-- Procedure: PROC_CreateNewVaccinator
-- This procedure is used to create a new vaccinator if one with the given iRDNumber does not already exist.
USE Vaccinations;
GO
CREATE OR ALTER PROCEDURE PROC_CreateNewVaccinator
    @iRDNumber CHAR(10),
    @preferredName NCHAR(20)
AS
BEGIN
    -- Check if a vaccinator with the given iRDNumber already exists.
    IF NOT EXISTS (SELECT 1 FROM Vaccinator WHERE iRDNumber = @iRDNumber)
    BEGIN
        -- If not, insert the new vaccinator into the "Vaccinator" table and print a success message.
        INSERT INTO Vaccinator (iRDNumber, preferredName)
        VALUES (@iRDNumber, @preferredName);
        PRINT 'Vaccinator Created Successfully.';
    END
    ELSE
    BEGIN
        -- If a vaccinator with the same iRDNumber exists, print an error message.
        PRINT 'Vaccinator with iRDNumber ' + @iRDNumber + ' already exists.';
    END
END;
GO

-- Procedure: PROC_BulkLoadVaccinators
-- This procedure is used to bulk load vaccinators from a specified file.
CREATE OR ALTER PROCEDURE PROC_BulkLoadVaccinators
    @FilePath NVARCHAR(200)
AS
BEGIN
    BEGIN TRY
        DECLARE @SqlStatement NVARCHAR(400);
        -- Generate a dynamic SQL statement to perform a bulk insert of vaccinators from the specified file.
        SET @SqlStatement = 'BULK INSERT Vaccinator FROM ''' + @FilePath + ''' WITH (FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n'', FIRSTROW = 2)';
        EXEC sp_executesql @SqlStatement;
        PRINT 'Bulk Loading Vaccinators Completed Successfully.';
    END TRY
    BEGIN CATCH
        -- In case of an error, print an error message with details.
        PRINT 'Error occurred in bulk load: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Procedure: PROC_CreateAppointment
-- This procedure is used to create a new appointment if one with the same place, slot, and time does not already exist.
CREATE OR ALTER PROCEDURE PROC_CreateAppointment
    @placeId CHAR(10),
    @slot TINYINT,
    @apptTime DATETIME,
    @vaccineNumber TINYINT,
    @personId CHAR(12),
    @vialNumber CHAR(15),
    @vaccinator CHAR(10)
AS
BEGIN
    -- Check if an appointment with the same place, slot, and time already exists.
    IF NOT EXISTS (SELECT 1 FROM Appointment WHERE placeId = @placeId AND slot = @slot AND apptTime = @apptTime)
    BEGIN
        -- If not, insert the new appointment into the "Appointment" table and print a success message.
        INSERT INTO Appointment (placeId, slot, apptTime, vaccineNumber, personId, vialNumber, vaccinator)
        VALUES (@placeId, @slot, @apptTime, @vaccineNumber, @personId, @vialNumber, @vaccinator);
        PRINT 'Appointment Created Successfully.';
    END
    ELSE
    BEGIN
        -- If an appointment with the same place, slot, and time exists, print an error message.
        PRINT 'Appointment already exists at this place, slot, and time.';
    END
END;
GO

-- Procedure: PROC_BulkLoadAppointments
-- This procedure is used to bulk load appointments from a specified file.
CREATE OR ALTER PROCEDURE PROC_BulkLoadAppointments
    @FilePath NVARCHAR(200)
AS
BEGIN
    BEGIN TRY
        DECLARE @SqlStatement NVARCHAR(400);
        -- Generate a dynamic SQL statement to perform a bulk insert of appointments from the specified file.
        SET @SqlStatement = 'BULK INSERT Appointment FROM ''' + @FilePath + ''' WITH (FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n'', FIRSTROW = 2)';
        EXEC sp_executesql @SqlStatement;
        PRINT 'Bulk Loading the Appointments Completed Successfully.';
    END TRY
    BEGIN CATCH
        -- In case of an error, print an error message with details.
        PRINT 'Error occurred in bulk load: ' + ERROR_MESSAGE();
    END CATCH
END;
