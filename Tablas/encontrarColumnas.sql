select s.name
,t.name as nombreTabla
, c.name as nombreColumna

from sys.Tables as t inner join sys.columns as c on t.object_id = c.object_id 
inner join sys.schemas as s ON t.schema_id = s.schema_id

where c.name = 'partNum' and c.name = 'Linedesc'
--and c.name = 'LineDesc'




