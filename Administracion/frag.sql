/************************************************
Fragmentacion de Indices de toda la Instancia
(c) 20160914 Henry Troncoso
************************************************/

IF OBJECT_ID('tempdb..#db') IS NOT NULL
drop table #db

create table #db(id int identity (1,1), 
name nvarchar (50) )
insert into #db (name)
select name  from sys.databases
where name not in ('master', 'model', 'msdb', 'tempdb', 'SSISDB')
AND  state_desc = 'ONLINE' and compatibility_level >= 100 

IF OBJECT_ID('tempdb..##frag') IS NOT NULL
drop table ##frag

create table ##frag
(BaseDatos sysname ,
Tabla sysname ,
Indice sysname,
Frag float)

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


SET @command ='use ' +  @db + 
'
 insert into ##frag
SELECT db_name (),
 OBJECT_NAME(l.object_id) AS object_name,
  i.name, l.avg_fragmentation_in_percent
FROM (
      SELECT object_id,index_id,partition_number,index_type_desc,
      index_depth,avg_fragmentation_in_percent,fragment_count,page_count
      FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,NULL)) AS l
 JOIN sys.indexes i
  ON l.object_id = i.object_id
  AND l.index_id = i.index_id
 JOIN sys.objects o
  ON l.object_id = o.object_id
WHERE
-- variable de la fragmentacion
  l.avg_fragmentation_in_percent > 5 
  AND page_count > 10
  AND l.index_id > 0
ORDER BY
  l.avg_fragmentation_in_percent DESC

'
	begin
			exec  (@command)		
end

SET @min = @min + 1
end

  select  * from ##frag

GO