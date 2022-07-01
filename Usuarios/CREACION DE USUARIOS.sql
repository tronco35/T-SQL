--CREACION DE USUARIOS

USE [master]
GO
if not exists (select name from sys.syslogins
where name = 'CORPBANCA\omar-rodriguez' )
CREATE LOGIN [CORPBANCA\omar-rodriguez] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO


use IntegrationBatch
if not exists (select name from  sys.database_principals
where name = 'CORPBANCA\omar-rodriguez')
create user [CORPBANCA\omar-rodriguez] from login [CORPBANCA\omar-rodriguez]
go

exec sp_addrolemember 'db_owner', 'CORPBANCA\omar-rodriguez';
go

--exec sp_addrolemember 'SSIS_ADMIN', 'CORPBANCA\omar-rodriguez';
--go

--alter authorization on database::RCS to [CORPBANCA\omar-rodriguez]


--COMPARAR CON OTRO USUARIO
--select name from sys.syslogins
--where name = 'HFSG\gl16341'
