

--DROP TRIGGER Trig_Prevent_Drop_Database ON ALL SERVER

CREATE TRIGGER Trig_Prevent_Drop_Database ON ALL SERVER

FOR CREATE_DATABASE,ALTER_DATABASE,DROP_DATABASE, update_database

AS

RAISERROR('Dropping of databases has been disabled on this server.', 16,1);

ROLLBACK;

GO

--DROP DATABASE Noborrar 