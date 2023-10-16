
-- =============================================
-- Author:	Amit Sarkar
-- Date:	13.09.2023
-- Modified:	<>
-- Description:	Procedure to create a New Place
-- =============================================

DROP PROCEDURE IF EXISTS createPlace
GO

CREATE PROCEDURE createPlace
	@id char(10) = '', 
	@longName nvarchar(50) = '',
	@maxSlots tinyint = 1
AS
BEGIN
	INSERT INTO Place(id,longName,maxSlots) 
	VALUES (@id, @longName, @maxSlots)
END
GO