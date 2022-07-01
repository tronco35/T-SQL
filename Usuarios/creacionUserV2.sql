/******************************************
--CREACION DE USUARIOS
(c) 19092016 Henry Troncoso Valencia

*******************************************/


declare @user nvarchar (50) 
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) 
set @db = 'dbSafyr' -- Base de datos
set @user =  'CS_OYDBusIII' --usuario

SET @command = '

USE [master]

if not exists (select name from sys.syslogins
where name = ' + '''' + @user  + '''' +  ') 
CREATE LOGIN '+ '[' + @user + ']' + '
FROM WINDOWS WITH DEFAULT_DATABASE=[master]


use ' +  @db  + '
if not exists (select name from  sys.database_principals
where name =' + '''' + @user  + '''' + ')

create user ' + '[' + @user + ']' + ' from login ' + '[' + @user + ']' +' 

exec sp_addrolemember' +  '''db_owner''' -- Modifico el roll database deseado
 + ',' + '''' + @user  + '''' 


exec (@command)		
go

