-- =============================================
-- Description:	Procedure to create an appointment
-- =============================================
USE Vaccinations

DROP PROCEDURE IF EXISTS createAppointment
GO

CREATE PROCEDURE createAppointment
	@placeId char(10) = '', 
	@slot tinyint = 1,
	@apptTime datetime2(0) = NULL
AS
BEGIN
	INSERT INTO Appointment(placeId,slot,apptTime) 
		VALUES (@placeId, @slot, @apptTime)
END

-- Test




