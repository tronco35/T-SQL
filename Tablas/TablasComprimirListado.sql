/*********** Tablas Candidatas de Compresion***********************
*(c) Henry Troncoso Valencia
*Basado en Tribal SQL
*Poca frecuencia en el acceso
*pocas actualizaciones
*escaneada frecuentemente

Advertancia:
Validar que la instacia lleve mas de un mes sin reiniciar
*****************************************************************/


use DWHUnificada
go
select CONVERT(sysname, SERVERPROPERTY('servername')) as Instancia, DB_NAME ()   as BaseDatos,
sc.name as Esquema, 
o.name as Tabla,
i.name as Indice,
s.user_updates * 100.0 / ( s.user_seeks + s.user_scans + 
+ s.user_lookups + s.user_updates 
) as Update_pct,

s.user_scans * 100.0 /( s.user_seeks + s.user_scans + 
+ s.user_lookups + s.user_updates 
) as ScanPct
from sys.dm_db_index_usage_stats as s 
inner join sys.objects as o ON s.[object_id] = o.[object_id]
inner join sys.schemas as sc ON o.[schema_id] = sc.[schema_id]
inner join sys.indexes as i ON s.[object_id] = i.[object_id] 
and s.index_id = i.[index_id]

where s.database_id = db_id ()
AND o.is_ms_shipped  = 0 
and
 s.user_updates * 100.0 / ( s.user_seeks + s.user_scans + 
+ s.user_lookups + s.user_updates 
) < 5
and 
s.user_scans * 100.0 /( s.user_seeks + s.user_scans + 
+ s.user_lookups + s.user_updates 
) > 80 

order by s.user_scans * 100.0 /( s.user_seeks + s.user_scans + 
+ s.user_lookups + s.user_updates 
) desc








