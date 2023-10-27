CREATE OR ALTER TRIGGER Trigger_CancelAppointment
ON [Vaccinations].[dbo].[Appointment]
AFTER UPDATE
AS
BEGIN
    IF UPDATE(personId) AND NOT EXISTS (SELECT * FROM INSERTED WHERE personId IS NOT NULL)
    BEGIN
        -- Insert canceled appointments into the Old Appointments table
        INSERT INTO OldAppointment (id, personId, reason, missed)
        SELECT id, d.personId, 'Changed appointment', 0
        FROM DELETED d;
    END;
END;

-- TEST
UPDATE Appointment SET personId = NULL WHERE [id] = 5800;