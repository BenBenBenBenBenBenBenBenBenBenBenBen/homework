<<<<<<< HEAD
USE Vaccinations;
GO
-- Trigger: Trg_CancelAppointment
-- This trigger fires after an update on the "Appointment" table and checks for changes in the "personId" column.
CREATE OR ALTER TRIGGER Trg_CancelAppointment
ON Appointment
AFTER UPDATE
AS
BEGIN
    -- Check if the "personId" column was updated and the new value is NULL.
    IF UPDATE(personId) AND NOT EXISTS (SELECT * FROM INSERTED WHERE personId IS NOT NULL)
    BEGIN
        -- If the condition is met, insert a new record into the "OldAppointment" table.
        INSERT INTO OldAppointment (id, personId, reason, missed)
        -- Select data from the "DELETED" table, indicating a changed appointment with a reason and not marked as missed.
        SELECT D.id, D.personId, 'Changed appointment', 0 FROM DELETED D;
=======
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
>>>>>>> 8a310f5db5835a6e766bcb098c8113828b409a30
    END;
END;

-- TEST
<<<<<<< HEAD
-- This is a test update to demonstrate the trigger's functionality. It sets the "personId" to NULL for a specific appointment.
UPDATE Appointment SET personId = NULL WHERE id = 5800;
=======
UPDATE Appointment SET personId = NULL WHERE [id] = 5800;
>>>>>>> 8a310f5db5835a6e766bcb098c8113828b409a30
