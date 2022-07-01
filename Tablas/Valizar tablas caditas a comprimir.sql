/*********** Tablas Candidatas de Compresion***********************
*Tribal SQL
*Poca frecuencia en el acceso
*pocas actualizaciones
*escaneada frecuentemente
*****************************************************************/

select sc.name as Esquema, 
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
AND ( s.user_seeks + s.user_scans + s.user_lookups + s.user_updates
) > 0;










