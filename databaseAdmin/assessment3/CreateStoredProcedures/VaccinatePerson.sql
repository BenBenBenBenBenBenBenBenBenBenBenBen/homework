-- =============================================
-- Description:	Procedure to Vaccinate a Person
-- =============================================
USE Vaccinations

DROP PROCEDURE IF EXISTS vaccinatePerson
GO

CREATE PROCEDURE vaccinatePerson
	@id int, 
	@vaccinatorId char(10) = NULL,
	@vialNumber char(15) = NULL
AS
BEGIN
	UPDATE Appointment
		SET vaccinator = @vaccinatorId, vialNumber = @vialNumber
			WHERE id=@id
END

GO

-- Test
-- 
--EXEC vaccinatePerson @id=1437, @vaccinatorId='12321562', @vialNumber='SC0001432'
--SELECT * FROM Appointment WHERE vaccinator IS NOT NULL





