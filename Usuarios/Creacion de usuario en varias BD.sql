/******************************************
--CREACION DE USUARIOS en varias BD
(c) 16112016 Henry Troncoso Valencia

*******************************************/
declare @dbLista table 
(id int identity (1,1),
nombre nvarchar (50)) 
 -- Bases de datos
insert into @dbLista (nombre)
values
('D_ClientTrade'),
--('D_TSManagement')
--,('SerivaCapaDatos'),
--('ReportesTesoreria_Soporte')
----usuarios
declare @user nvarchar (50) 
set @user =  'CORPBANCA\hector-martinez' --usuario

DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) -- Base de datos

SELECT @max = (select MAX (id) from @dbLista)

SELECT @min = 1
WHILE @min <= @max

BEGIN
SET @command = NULL

select @db = nombre from @dbLista
where ID = @min

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

	

begin
exec (@command)



end
SET @min = @min + 1



end

go

