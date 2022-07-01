
/*********************************************************************************************
Compresion de tablas superiores a 3 GB v1(2016-08-17)
(C) 20160921, Henry Troncoso Valencia
esta Consulta aplica sobre toda la instancia
**************************************Advertencia.*********************************************

*********************************************************************************************/

IF OBJECT_ID('tempdb..##DBPESOINI') IS NOT NULL
drop table ##DBPESOINI


create table ##DBPESOINI
(name sysname,
pesoINI int
)

insert into ##DBPESOINI (name, pesoINI)
select d.name , sum (size * 8) /1024  as "Tamañoini" from sys.master_files as m 
inner join sys.databases as d ON m.database_id = d.database_id
where d.name not in ('master', 'model', 'msdb', 'tempdb', 'SSISDB') 
group by d.name 

--valida exitencia de tablas tablas temporales


IF OBJECT_ID('tempdb..##TableSizes') IS NOT NULL
drop table ##TableSizes
create table  ##TableSizes

(
            TableName NVARCHAR(255),
            TableRows INT,
            ReservedSpaceKB VARCHAR(20),
            DataSpaceKB VARCHAR(20),
            IndexSizeKB VARCHAR(20),
            UnusedSpaceKB VARCHAR(20)
)
go

IF OBJECT_ID('tempdb..##TableSizes2') IS NOT NULL
drop table ##TableSizes2
create table ##TableSizes2


(			db sysname ,
            TableName NVARCHAR(255),
            TableRows INT,
            ReservedSpaceKB VARCHAR(20),
            DataSpaceKB VARCHAR(20),
            IndexSizeKB VARCHAR(20),
            UnusedSpaceKB VARCHAR(20)
)

--listado de Tablas Grandes de la BD
IF OBJECT_ID('tempdb..#db') IS NOT NULL
drop table #db

create table #db(id int identity (1,1), 
name nvarchar (50) )
insert into #db (name)
select name  from sys.databases
where name not in ('master', 'model', 'msdb', 'tempdb', 'SSISDB')
AND  state_desc = 'ONLINE' and compatibility_level >= 100 

IF OBJECT_ID('tempdb..##TablasGrandes') IS NOT NULL
drop table ##TablasGrandes
create table ##TablasGrandes
(id int identity (1,1),
db sysname,
TableName sysname,
"Tamaño Tabla" int)


DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @name NVARCHAR(50) -- Nombre de la base de datos 
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) -- Base de datos
SELECT @max = (SELECT count(database_id) from sys.databases where 
name not in ('master', 'model', 'msdb', 'tempdb', 'SSISDB')AND  state_desc = 'ONLINE'
and compatibility_level >= 100   )

SELECT @min = 1
WHILE @min <= @max
	
	BEGIN
		SET @command = NULL


select @db = name from #db
where  ID = @min

SET @command ='use ' +  @db + '

INSERT INTO ##TableSizes
EXEC sp_msforeachtable '  + '''sp_spaceused ''' + '''?'''''''+ '

INSERT INTO ##TableSizes2
select db_name (), TableName,TableRows , ReservedSpaceKB , DataSpaceKB, IndexSizeKB ,
            UnusedSpaceKB 
			from ##TableSizes
			insert INTO  ##TablasGrandes		
SELECT db, TableName, cast (replace (DataSpaceKB, ' + '''KB''' +' , ' + ''' '''  + ')as int )/1024 as "Tamaño Tabla"
FROM ##TableSizes2
where cast (replace (DataSpaceKB, '  + '''KB''' +' , ' + ''' '''  + ')as int )/1024 >= 3120' -- mayores a 3 GB
+'
ORDER BY cast (replace (DataSpaceKB, '  + '''KB''' +' , ' + ''' '''  + ')as int )desc' 


	begin
			exec (@command)		
end
 
SET @min = @min + 1
end
go

IF OBJECT_ID('tempdb..##esqtbl') IS NOT NULL
drop table ##esqtbl
create table ##esqtbl
(id int identity (1,1),
db sysname,
esquema sysname,
tabla sysname)

--Declaraciones
DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) -- Base de datos
declare @esquema varchar (10)
declare @tabla varchar (100)
SELECT @max =  (select count (id) from #db)
SELECT @min = 1
WHILE @min <= @max
	
	BEGIN
		SET @command = NULL


select @db = name from #db
where  ID = @min

SET @command ='use ' +  @db + '

insert into ##esqtbl
SELECT db_name () ,  C.name, t.NAME FROM SYS.tables AS T INNER JOIN SYS.schemas AS C ON T.schema_id = C.schema_id
inner join ##TablasGrandes as g ON t.NAME = g.TableName
group by   C.name, t.NAME

'
begin
			exec  (@command)		
end
 
SET @min = @min + 1
end
go


IF  EXISTS (
select * from tempdb.sys.tables
where name like '##cOMPRESS%')
drop table ##cOMPRESS
go
create table ##cOMPRESS 
([object_name] sysname ,	[schema_name]  sysname,	[index_id] int,	[partition_number] int,	
 size_with_current_compression_settingKB int,	size_with_requested_compression_settingKB int,	
 sample_size_with_current_compression_settingKB int,
 sample_size_with_requested_compression_settingKB int 
)
--Declaraciones
DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) -- Base de datos
declare @esquema varchar (10)
declare @tabla varchar (100)
SELECT @max =  (select count (id) from ##esqtbl)
SELECT @min = 1
WHILE @min <= @max
	
	BEGIN
		SET @command = NULL
select @db = db, @esquema = esquema, @tabla = tabla from ##esqtbl
where  ID = @min

SET @command ='use ' +  @db + '
 INSERT INTO  ##cOMPRESS   ([object_name],	[schema_name],	index_id,	partition_number,	
 size_with_current_compression_settingKB,	size_with_requested_compression_settingKB,	sample_size_with_current_compression_settingKB,
 sample_size_with_requested_compression_settingKB 
) 

EXEC sp_estimate_data_compression_savings '  + '''' + RTRIM (@esquema)  + ''''  + ' , ' + ''''  +
 RTRIM (@tabla) + ''''  + ' , NULL, NULL' + ' , ' + '''page''

 ' 

 begin
			exec  (@command)		
end
 
SET @min = @min + 1
end
go

DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) -- Base de datos
declare @tablaESQ varchar (100)
SELECT @max =  (select count (distinct id) from ##cOMPRESS as s inner join ##esqtbl as e ON s.object_name = e.tabla
where size_with_requested_compression_settingKB > 0 and size_with_current_compression_settingKB > 0
and cast ((size_with_requested_compression_settingKB )as bigint) * 100 / size_with_current_compression_settingKB < 70
)
SELECT @min = 1
WHILE @min <= @max



	
	BEGIN
		SET @command = NULL
select @db = db , @tablaESQ = [schema_name] + '.' + [OBJECT_NAME]  from ##cOMPRESS as s 
inner join ##esqtbl as e ON s.[object_name] = e.tabla
where  ID = @min 
and  size_with_requested_compression_settingKB > 0 and size_with_current_compression_settingKB > 0
and cast ((size_with_requested_compression_settingKB )as bigint) * 100 / size_with_current_compression_settingKB < 70


SET @command ='use ' +  @db + '
ALTER TABLE ' + RTRIM (@tablaESQ) + ' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE)

'
begin
			exec (@command)		
end
 
SET @min = @min + 1
end
go


IF  EXISTS (
select * from tempdb.sys.tables
where name like '#db2%')
drop table #db2
go
create table #db2
(id int identity (1,1),
bd sysname)


insert into #db2
select distinct (db)
from ##cOMPRESS as s 
inner join ##esqtbl as e ON s.[object_name] = e.tabla
where  size_with_requested_compression_settingKB > 0 and size_with_current_compression_settingKB > 0
and cast ((size_with_requested_compression_settingKB )as bigint) * 100 / size_with_current_compression_settingKB < 70

IF  EXISTS (
select * from tempdb.sys.tables
where name like '##compindx%')
drop table ##compindx
go
create table ##compindx
(id int identity (1,1),
db sysname,
indice sysname,
tabla sysname)


--Valida si hay indices para comprimir

if exists (select [SCHEMA_NAME]
from ##cOMPRESS
where [SCHEMA_NAME] is not null
)
--listado de indices por comprimir
DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) -- Base de datos
select @max = count (bd) from  #db2


SELECT @min = 1
WHILE @min <= @max

	BEGIN
		SET @command = NULL
select @db = bd from #db2
where id = @min

SET @command ='use ' +  @db + '
insert into ##compindx
SELECT db_name (),  I.name as "Index" ,c.schema_name + ' + '''.''' + ' + c.object_name as Tabla
from ##cOMPRESS as c INNER JOIN SYS.TABLES as t ON c.object_name = t.name 
inner join sys.indexes AS I ON T.object_id = I.object_id 
and c.index_id = I.index_id
WHERE I.name is not null and size_with_requested_compression_settingKB > 0 and size_with_current_compression_settingKB > 0
and cast ((size_with_requested_compression_settingKB )as bigint) * 100 / size_with_current_compression_settingKB < 70 

'
begin
			exec (@command)		
end
 
SET @min = @min + 1
end
go


--limpia indices
IF  EXISTS (
select * from tempdb.sys.tables
where name like '##complimpio%')
drop table ##complimpio
go
create table ##complimpio
(id int identity (1,1),
bd sysname,
indice sysname,
tabla sysname)

insert into ##complimpio
select distinct db, indice, tabla 
from ##compindx





--compresion de indices
DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @command NVARCHAR(max)
declare @index as sysname
declare @tabla as sysname
declare @db nvarchar (50) -- Base de datos

select @max =  count (* ) from ##complimpio
SELECT @min = 1
WHILE @min <= @max

	BEGIN

	SET @command = NULL
	select @db = bd, @index = indice , @tabla = tabla   from ##complimpio
where id = @min

SET @command ='use ' +  @db + '
' + 'ALTER INDEX '  +  RTRIM (@index) + ' ON ' +  RTRIM (@tabla)
 +' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE)'

 begin
			exec (@command)		
end
 
SET @min = @min + 1
end
go


IF  EXISTS (
select * from tempdb.sys.tables
where name like '##bdlimpio%')
drop table ##bdlimpio
go
create table ##bdlimpio
(id int identity (1,1),
bd sysname
)

insert into ##bdlimpio
select distinct bd
from ##complimpio


--compresion BD
DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @command NVARCHAR(max)
declare @db nvarchar (50) -- Base de datos

select @max =  count (* ) from ##bdlimpio
SELECT @min = 1
WHILE @min <= @max
	BEGIN

	SET @command = NULL
	select  @db = bd from ##bdlimpio
where id = @min

SET @command =
'DBCC SHRINKDATABASE(N' + '''' +  @db + '''' + ')
GO '

 begin
			exec (@command)		
end
 
SET @min = @min + 1
end

go


IF OBJECT_ID('tempdb..##DBPESOFIN') IS NOT NULL
drop table ##DBPESOFIN
create table ##DBPESOFIN
(name sysname,
pesofin int
)
insert into ##DBPESOFIN (name, pesofin)
select d.name , sum (size * 8) /1024  from sys.master_files as m 
inner join sys.databases as d ON m.database_id = d.database_id
where d.name not in ('master', 'model', 'msdb', 'tempdb', 'SSISDB') 
group by d.name 


SELECT I.name AS BaseDatos, Pesoini, Pesofin  
FROM  ##DBPESOINI AS I INNER JOIN  ##DBPESOFIN AS 
F on I.name = F.name INNER JOIN ##bdlimpio AS L ON F.NAME = l.bd
