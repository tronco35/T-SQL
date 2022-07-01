/*********** Tablas Candidatas de Compresion***********************
*(c) Henry Troncoso Valencia
*Basado en Tribal SQL
*Poca frecuencia en el acceso
*pocas actualizaciones
*escaneada frecuentemente

Advertancia:
Validar que la instacia lleve mas de un mes sin reiniciar
*****************************************************************/
IF  EXISTS (
select * from tempdb.sys.tables
where name like '#bases%')
drop table  #bases
go

--
select database_id 
into #bases
from sys.databases
where name not in ('master', 'model', 'msdb', 'tempdb')

declare @id as int
DECLARE @gozalo VARCHAR(max)

declare  db cursor for
select database_id from #bases

open db
FETCH NEXT
FROM db 
into  @id

while @@FETCH_STATUS = 0
BEGIN

SELECT @gozalo = 'select sc.name as Esquema, 
o.name as Tabla,
i.name as Indice,
s.user_updates * ' + cast (100.0 as nvarchar)  + +' / ( s.user_seeks + s.user_scans + 
+ s.user_lookups + s.user_updates 
) as Update_pct, s.user_scans * ' + cast (100.0 as nvarchar) +  '/( s.user_seeks + s.user_scans + 
+ s.user_lookups + s.user_updates 
) as ScanPct
into #objcompress
from sys.dm_db_index_usage_stats as s 
inner join sys.objects as o ON s.[object_id] = o.[object_id]
inner join sys.schemas as sc ON o.[schema_id] = sc.[schema_id]
inner join sys.indexes as i ON s.[object_id] = i.[object_id] 
and s.index_id = i.[index_id]
where s.database_id = ' +  cast (@id as nvarchar) + ' AND o.is_ms_shipped  = 0 and s.user_updates * ' +
cast (100.0 as nvarchar) + ' / ( s.user_seeks + s.user_scans + + s.user_lookups + s.user_updates 
) < 5and s.user_scans * ' + cast (100.0 as nvarchar) + '/( s.user_seeks + s.user_scans + s.user_lookups + s.user_updates ) >'+
cast (80.0 as nvarchar) + ' order by s.user_scans * ' + cast (100.0 as nvarchar) + ' /( s.user_seeks + s.user_scans + 
+ s.user_lookups + s.user_updates 
) desc
'
exec (@gozalo)

FETCH NEXT
FROM db 
into  @id
end

CLOSE db
DEALLOCATE db



select * from #objcompress


 




