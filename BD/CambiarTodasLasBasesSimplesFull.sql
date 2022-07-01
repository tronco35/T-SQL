--=============================================================
--AMBIENTES PREVIOS CAMBIAR TODAS LAS BD de simple a full
--(c) Henry Troncoso 17092020
--=============================================================

IF OBJECT_ID('tempdb..##db') IS NOT NULL
drop table ##db
create table ##db(id int identity (1,1) primary key clustered,
BD nvarchar (50))
insert into ##db (BD)
select D.NAME AS BD
from sys.databases as d
where d.name not in ('master','model','msdb','tempdb') and  recovery_model_desc = 'simple'

DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @name NVARCHAR(50) -- Nombre de la base de datos
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) -- Base de datos


SELECT @max =  COUNT (BD)  FROM ##db 

SELECT @min = 1
WHILE @min <= @max

BEGIN
SET @command = NULL
　
select @db = BD from ##db
where ID = @min


SET @command = 'USE [master]
ALTER DATABASE '  + @db + ' SET RECOVERY FUll WITH NO_WAIT
'
begin
EXEC (@command)

end
SET @min = @min + 1

end

GO

