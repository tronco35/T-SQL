
--estado de indices
SELECT i.name,
s.name,
  OBJECT_NAME(l.object_id) AS object_name,
     l.avg_fragmentation_in_percent
FROM (
      SELECT object_id,index_id,partition_number,index_type_desc,
      index_depth,avg_fragmentation_in_percent,fragment_count,page_count
      FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,NULL)
     ) AS l
 JOIN sys.indexes i
  ON l.object_id = i.object_id
  AND l.index_id = i.index_id
 JOIN sys.objects o
  ON l.object_id = o.object_id

  inner join sys.schemas as s On o.schema_id = s.schema_id
WHERE
-- variable de la fragmentacion
  l.avg_fragmentation_in_percent >30
  AND page_count > 10
  AND l.index_id > 0
ORDER BY
  l.avg_fragmentation_in_percent DESC,
  l.page_count,
  l.object_id,
  l.index_id
