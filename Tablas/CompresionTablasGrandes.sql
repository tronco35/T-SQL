
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

*********************************************************************************************/


--valida exitencia de tablas tablas temporales

IF  EXISTS (
select * from tempdb.sys.tables
where name like '#TablasGrandes%')
drop table #TablasGrandes
go


IF  EXISTS (
select * from tempdb.sys.tables
where name like '#cOMPRESS%')
drop table #cOMPRESS
go


declare @TableSizes
table 

(
            TableName NVARCHAR(255),
            TableRows INT,
            ReservedSpaceKB VARCHAR(20),
            DataSpaceKB VARCHAR(20),
            IndexSizeKB VARCHAR(20),
            UnusedSpaceKB VARCHAR(20)
)

--listado de Tablas Grandes de la BD
INSERT INTO @TableSizes
EXEC sp_msforeachtable 'sp_spaceused ''?'''

SELECT  TableName, cast (replace (DataSpaceKB, 'KB' , '' )as int )/1024 "Tamaño Tabla"
INTO #TablasGrandes
  FROM @TableSizes
where cast (replace (DataSpaceKB, 'KB' , '' )as int )/1024 >= 3120-- mayores a 3 GB
ORDER BY  cast (replace (DataSpaceKB, 'KB' , '' )as int )desc

create table #cOMPRESS 
([object_name] sysname ,	[schema_name]  sysname,	[index_id] int,	[partition_number] int,	
 size_with_current_compression_settingKB int,	size_with_requested_compression_settingKB int,	sample_size_with_current_compression_settingKB int,
 sample_size_with_requested_compression_settingKB int 
)

--Declaraciones
declare @esquema varchar (10)
declare @tabla varchar (100)
DECLARE @gozalo   VARCHAR (255)

--CursorDeEstimacionTablas
Declare csrtablasG cursor for 

SELECT  C.name AS ESQUEMA , t.NAME AS TABLA FROM SYS.tables AS T INNER JOIN SYS.schemas AS C ON T.schema_id = C.schema_id
inner join #TablasGrandes as g ON t.NAME = g.TableName

open csrtablasG 
FETCH NEXT
FROM csrtablasG 
into  @esquema, @tabla

while @@FETCH_STATUS = 0
BEGIN

SELECT @gozalo = 'EXEC sp_estimate_data_compression_savings ' + '''' + RTRIM (@esquema)  + ''''  + ' , ' + ''''  +
 RTRIM (@tabla) + ''''  + ' , NULL, NULL' + ' , ' + '''page'''

 INSERT INTO  #cOMPRESS   ([object_name],	[schema_name],	index_id,	partition_number,	
 size_with_current_compression_settingKB,	size_with_requested_compression_settingKB,	sample_size_with_current_compression_settingKB,
 sample_size_with_requested_compression_settingKB 
)
exec (@gozalo)

 FETCH NEXT
   FROM csrtablasG 
   into @esquema, @tabla
end

CLOSE csrtablasG 
DEALLOCATE csrtablasG 

--Valida si hay tablas para comprimir

if exists (select [SCHEMA_NAME]
from #cOMPRESS
where [SCHEMA_NAME] is not null
)



--COMPRIMIR TABLAS de mas de 3 GB

declare @ejecuta as varchar (100)
declare @tabla1 as sysname
declare CSR_compresionTabla cursor for 

select DISTINCT [SCHEMA_NAME] + '.' + [OBJECT_NAME] AS TABLA
from #cOMPRESS
--CANTIDAD QUE EN COMPARACION COMPRIMIRA EN %
WHERE CAST ((size_with_requested_compression_settingKB * 100.0)/ (size_with_current_compression_settingKB) as DECIMAL (20,2)) < 70 
-- ejecuta el cursor PMSreindex
open CSR_compresionTabla
FETCH NEXT
   FROM CSR_compresionTabla
   into @tabla1

      while @@FETCH_STATUS = 0

   BEGIN
-- ejecucucion
select @ejecuta = 'ALTER TABLE ' + RTRIM (@tabla1) + ' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE)'
 exec (@ejecuta)


FETCH NEXT
   FROM CSR_compresionTabla
   into @tabla1
end
-- cierre del cursor CSR_compresionTabla
CLOSE CSR_compresionTabla
DEALLOCATE CSR_compresionTabla

go


--Valida si hay indices para comprimir

if exists (select [SCHEMA_NAME]
from #cOMPRESS
where [SCHEMA_NAME] is not null
)


--compresion de indices
declare @ejecuta1 as varchar (100)
declare @index as sysname
declare @tabla1 as sysname
declare CSRCompresionIndex cursor for 

SELECT   I.name as "Index" ,c.schema_name + '.' + c.object_name as Tabla 
from #cOMPRESS as c INNER JOIN SYS.TABLES as t ON c.object_name = t.name inner join sys.indexes AS I ON T.object_id = I.object_id 
and c.index_id = I.index_id
WHERE CAST ((size_with_requested_compression_settingKB * 100.0)/ (size_with_current_compression_settingKB) as DECIMAL (20,2)) < 70 
and I.name is not null
open CSRCompresionIndex
FETCH NEXT
   FROM CSRCompresionIndex
   into @index, @tabla1
      while @@FETCH_STATUS = 0
   BEGIN
-- ejecucucion
select @ejecuta1 = 'ALTER INDEX '  +  RTRIM (@index) + ' ON ' +  RTRIM (@tabla1) +' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE)'
 exec (@ejecuta1)

FETCH NEXT
   FROM CSRCompresionIndex
    into @index, @tabla1
end
-- cierre del cursor CSR_compresionTabla
CLOSE CSRCompresionIndex
DEALLOCATE CSRCompresionIndex
go



/*********************************************************************************************
--Valida si se comprimio algun objeto de la BD 
--si lo hay hace una comparacion de tablas de antes y depues de la ejecucion 
*****************************Este lote es opcional********************************************
*********************************************************************************************/

if exists (select [SCHEMA_NAME]
from #cOMPRESS
where [SCHEMA_NAME] is not null
)

declare @TableSizesDespues
table 

(
            TableName NVARCHAR(255),
            TableRows INT,
            ReservedSpaceKB VARCHAR(20),
            DataSpaceKB VARCHAR(20),
            IndexSizeKB VARCHAR(20),
            UnusedSpaceKB VARCHAR(20)
)
go


DBCC SHRINKDATABASE(N'DWHGFBC_Hasta20161111')
go

