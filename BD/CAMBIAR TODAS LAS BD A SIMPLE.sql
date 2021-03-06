--=============================================================
--AMBIENTES PREVIOS CAMBIAR TODAS LAS BD A SIMPLE Y COMPRIMIR =
--(c) Henry Troncoso 12122016
--=============================================================

IF OBJECT_ID('tempdb..##db') IS NOT NULL
drop table ##db
create table ##db(id int identity (1,1) primary key clustered,
BD nvarchar (50),
NombreLogico nvarchar (50) )
insert into ##db (BD, NombreLogico)
select D.NAME AS BD, s.name as NombreLogico
from sys.databases as d
inner join  sys.master_files as s ON d.database_id = s.database_id 
where type_desc ='log' and d.name not in ('master','model','msdb','tempdb') and  recovery_model_desc = 'FULL'

DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @name NVARCHAR(50) -- Nombre de la base de datos
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) -- Base de datos
DECLARE @nLOGICO NVARCHAR (50) -- NOMBRE LOGICO

SELECT @max =  COUNT (BD)  FROM ##db 

SELECT @min = 1
WHILE @min <= @max

BEGIN
SET @command = NULL
　
select @db = BD, @nLOGICO = NombreLogico from ##db
where ID = @min


SET @command = 'USE [master]
ALTER DATABASE '  + @db + ' SET RECOVERY SIMPLE WITH NO_WAIT
USE ' + @db + '
DBCC SHRINKFILE (N''' + @nLOGICO + ''' , 0, TRUNCATEONLY)
'
begin
EXEC (@command)

end
SET @min = @min + 1

end

GO

