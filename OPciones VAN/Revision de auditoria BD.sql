/*==================================================
*(c)  12/19/2016 Henry Troncoso
*
* Ver BD que tienen Auditoria en la instancia
==================================================*/
 
 
IF OBJECT_ID('tempdb..##basesaudit') IS NOT NULL
drop table ##basesaudit
 go
create table ##basesaudit
(id int identity (1,1) primary key clustered,
name nvarchar (50),
nombreAuditoriaDB nvarchar (50)
, auditoria nvarchar (50)
,Estado nvarchar (100)
, ruta nvarchar (max) )
 
declare @bases as table
(id int identity (1,1) primary key clustered,
name nvarchar (50))
 
insert into @bases (name)
select name from sys.databases
where state = 0
 
DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @name NVARCHAR(100) -- Nombre de la base de datos
DECLARE @command NVARCHAR(max)
 
SELECT @max =  COUNT (name)  FROM @bases
 
SELECT @min = 1
WHILE @min <= @max
BEGIN
SET @command = NULL
 
select @name = name from @bases
where  ID = @min
 
SET @command = 'USE ' + @name + '
insert into ##basesaudit (name,
nombreAuditoriaDB 
,auditoria 
,Estado 
,ruta )
select DB_NAME () as BasedeDatos, P.name AS AUDITS_DB, T.NAME AS AUDITS, T.status_desc, audit_file_path
from sys.database_audit_specifications AS P inner join sys.server_audits as a ON p.audit_guid = a.audit_guid
left JOIN sys.dm_server_audit_status 
AS T on a.name  = T.name
where p.is_state_enabled = 1
'
begin
exec (@command)
 
end
SET @min = @min + 1
 
end
 
GO
 
select name, NombreAuditoriaDB, auditoria, Estado, Ruta 
from ##basesaudit
go

--select distinct auditoria
--from ##basesaudit


--CLCONFIRMING,5999 
--BOINFSQL26,61214 
--BOINFSQL11 
--BOINFSQL6 
--CLBDSQL2008-2\MSSQLSERVER02,49584
--BOINFPOPH
--BOINFSQL55 
--BOINFSQLCS 
--BOINFSQLTMCL
--BOINFSQLUSSCL 
--10.91.35.17,1450   -- sbccodbcorvus,1450	CORVUS


