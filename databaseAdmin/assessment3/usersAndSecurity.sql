/*Security Policy Document:

	This policy outlines the security settings, users, roles, and permissions required for the 
	"Vaccinations" database. The database will not be directly accessed by the public but only through stored procedures.
	Security measures are in place to minimize the risk of SQL injection.

	Users and Roles:
	databaseAdmin: A role with full control of the database.
	employee: A role with access to views and specific procedures, including PROC_CreateNewVaccinator and PROC_CreateAppointment.
	Security Settings and Permissions:
		The databaseAdmin role will have full control over the database, including SELECT, INSERT, UPDATE, DELETE, and EXECUTE permissions on all objects 
		(this is probably a bad idea because this makes if very easy for the dbAdmin to accidently delete all the data).
	The employee role will have limited permissions:
		SELECT permission on all views, including totalVaccinations, MissedAppointments, VaccinatedPeopleByAgeDecades, and vaccinatorStatistics.
		EXECUTE permission on the PROC_CreateNewVaccinator and PROC_CreateAppointment procedures.
		No direct access to tables or other database objects.
	SQL Scripts to Implement the Security Policy:*/

-- Create users and roles
CREATE LOGIN databaseAdminUserLogin WITH PASSWORD = 'Password';
CREATE LOGIN employeeUserLogin WITH PASSWORD = 'Password';
USE Vaccinations;
CREATE USER databaseAdminUser FOR LOGIN databaseAdminUserLogin;
CREATE USER employeeUser FOR LOGIN employeeUserLogin;
CREATE ROLE databaseAdmin;
CREATE ROLE employee;

-- Assign users to roles
ALTER ROLE databaseAdmin ADD MEMBER databaseAdminUser;
ALTER ROLE employee ADD MEMBER employeeUser;

-- Grant full control to databaseAdmin role
GRANT CONTROL ON DATABASE::Vaccinations TO databaseAdmin;
GRANT EXECUTE TO databaseAdmin;

-- Grant permissions to employee role
GRANT SELECT ON totalVaccinations TO employee;
GRANT SELECT ON MissedAppointments TO employee;
GRANT SELECT ON VaccinatedPeopleByAgeDecades TO employee;
GRANT SELECT ON vaccinatorStatistics TO employee;
GRANT EXECUTE ON PROC_CreateNewVaccinator TO employee;
GRANT EXECUTE ON PROC_CreateAppointment TO employee;
