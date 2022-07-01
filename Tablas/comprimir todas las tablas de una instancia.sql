
/*********************************************************************************************
Compresion de tablas superiores a 3 GB v1(2016-08-17)

(C) 2016, Henry Troncoso Valencia
La ejecucion solo aplica por Base de Datos 
Debe selecciona la base de datos la cual desea comprimir.

**************************************Advertencia.*********************************************
Esta query Utiliza la metadata de la Base de datos
Tenga en cuenta que esta query ejecuta varios cursores por lo que se debe realizar en horarios 
esclusivos de mantenimiento ya que genera alto impacto en el rendimiento de la base de datos en 
el momento de la consulta.

Uso Exclusivo Helm Bank.
*********************************************************************************************/


IF OBJECT_ID('tempdb..##BD') IS NOT NULL
drop table ##bd

create table ##BD
(id int identity (1,1) primary key clustered
, BD nvarchar (50)
)

insert into ##BD (bd)
select name from sys.databases where name not in ('master','msdb','model','tempdb')

DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @name NVARCHAR(50) -- Nombre de la base de datos
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) -- Base de datos
DECLARE @nLOGICO NVARCHAR (50) -- NOMBRE LOGICO
DECLARE @command2 NVARCHAR(max)

SELECT @max =  COUNT (BD)  FROM ##BD 


SELECT @min = 1
WHILE @min <= @max

BEGIN
SET @command = NULL
　
select @db = BD from ##BD
where ID = @min

SET @command = 'use ' + @db + '
' + '
IF  EXISTS (
select * from tempdb.sys.tables where name like ''#TablasGrandes%'')
drop table #TablasGrandes
go
IF  EXISTS (
select * from tempdb.sys.tables where name like ''#TableSizes%'')
drop table #TableSizes
go
IF  EXISTS (select * from tempdb.sys.tables where name like ''##COMPRESS%'')
drop table ##COMPRESS
go
create table #TableSizes 
(TableName NVARCHAR(255),TableRows INT,ReservedSpaceKB VARCHAR(20),DataSpaceKB VARCHAR(20),IndexSizeKB VARCHAR(20),UnusedSpaceKB VARCHAR(20) )
INSERT INTO #TableSizes
EXEC sp_msforeachtable ''sp_spaceused '''''  +  '?' + '''''''
go
SELECT  TableName, cast (replace (DataSpaceKB, ''KB'' , '''')as int )/1024 as "Tamano Tabla"
INTO #TablasGrandes FROM #TableSizes where cast (replace (DataSpaceKB, ''KB'' , '''' )as int )/1024 >= 512
ORDER BY  cast (replace (DataSpaceKB, ''KB'' , '''' )as int )desc
go
create table ##COMPRESS
([object_name] sysname , [schema_name]  sysname, [index_id] int,	[partition_number] int,	 size_with_current_compression_settingKB int,	size_with_requested_compression_settingKB int,	sample_size_with_current_compression_settingKB int, sample_size_with_requested_compression_settingKB int)
GO
declare @esquema varchar (10)
declare @tabla varchar (100)
DECLARE @gozalo VARCHAR (255)
Declare csrtablasG cursor for
SELECT C.name, t.NAME FROM SYS.tables AS T INNER JOIN SYS.schemas AS C ON T.schema_id = C.schema_id inner join  #TablasGrandes as g ON t.NAME COLLATE DATABASE_DEFAULT = g.TableName COLLATE DATABASE_DEFAULT
open csrtablasG
FETCH NEXT
FROM csrtablasG
into  @esquema, @tabla
while @@FETCH_STATUS = 0
BEGIN
SELECT @gozalo = ''EXEC sp_estimate_data_compression_savings '' + '''''''' + RTRIM (@esquema)  + ''''''''  + '' , ''  + ''''''''  + RTRIM (@tabla) + ''''''''  + '' , NULL, NULL'' + '' , '' + ''''''page''''''
INSERT INTO  ##COMPRESS   ([object_name], [schema_name],	index_id,	partition_number, size_with_current_compression_settingKB, size_with_requested_compression_settingKB,	sample_size_with_current_compression_settingKB, sample_size_with_requested_compression_settingKB)
exec (@gozalo)
FETCH NEXT FROM csrtablasG 
into @esquema, @tabla
end
CLOSE csrtablasG
DEALLOCATE csrtablasG
if exists (select [SCHEMA_NAME]
from ##COMPRESS where [SCHEMA_NAME] is not null)
declare @ejecuta as varchar (100)
declare @tabla1 as sysname
declare CSR_compresionTabla cursor for
select DISTINCT [SCHEMA_NAME] + ''.'' + [OBJECT_NAME] 
from ##COMPRESS WHERE CAST ((size_with_requested_compression_settingKB * 100.0)/ (size_with_current_compression_settingKB) as DECIMAL (20,2)) < 70
open CSR_compresionTabla
FETCH NEXT
FROM CSR_compresionTabla
into @tabla1
while @@FETCH_STATUS = 0
BEGIN
select @ejecuta = ''ALTER TABLE '' + RTRIM (@tabla1) + '' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE)''
exec (@ejecuta)
FETCH NEXT
FROM CSR_compresionTabla
into @tabla1
end
CLOSE CSR_compresionTabla
DEALLOCATE CSR_compresionTabla
go
--if exists (select [SCHEMA_NAME] from ##COMPRESS where [SCHEMA_NAME] is not null)
declare @ejecuta1 as varchar (100)
declare @index as sysname
declare @tabla1 as sysname
declare CSRCompresionIndex cursor for
SELECT   I.name as "Index" ,c.schema_name + ''.'' + c.object_name from ##COMPRESS as c INNER JOIN SYS.TABLES as t ON c.object_name COLLATE DATABASE_DEFAULT = t.name inner join sys.indexes AS I ON T.object_id  = I.object_id and c.index_id = I.index_id  WHERE CAST ((size_with_requested_compression_settingKB * 100.0)/ (size_with_current_compression_settingKB) as DECIMAL (20,2)) < 70 and I.name is not null
open CSRCompresionIndex
FETCH NEXT FROM CSRCompresionIndex
into @index, @tabla1
while @@FETCH_STATUS = 0
BEGIN
select @ejecuta1 = ''ALTER INDEX ''  +  RTRIM (@index) + '' ON '' +  RTRIM (@tabla1) + '' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE)''
exec (@ejecuta1)
FETCH NEXT
FROM CSRCompresionIndex
into @index, @tabla1
end
CLOSE CSRCompresionIndex
DEALLOCATE CSRCompresionIndex
go
'
set @command2 = 'DBCC SHRINKDATABASE(' + '''' + @db + '''' +')
go'


begin
print (@command)
print (@command2)

end
SET @min = @min + 1

end

GO