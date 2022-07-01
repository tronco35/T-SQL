/*
***************************************
*Elaborado por Henry Troncoso                        *
*reindexacion base de datos                               *
***************************************
*/

  -- Valores por declarar
  declare @object_name VARCHAR (128)
  declare @name VARCHAR (128)
  declare @esquema VARCHAR (128)
  DECLARE @gozalo   VARCHAR (255)
--declaracion del cursor que consulta indices por reindexar
declare PMSreindex cursor for

SELECT
  OBJECT_NAME(l.object_id) AS Tabla,
  i.name as indice, c.name as esquema
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
      join sys.schemas as c ON c.schema_id = o.schema_id 
WHERE
-- variable de la fragmentacion
  l.avg_fragmentation_in_percent between 5 and 30
  AND page_count > 10
  AND l.index_id > 0
ORDER BY
  l.avg_fragmentation_in_percent DESC,
  l.page_count,
  l.object_id,
  l.index_id
-- ejecuta el cursor PMSreindex
open PMSreindex
FETCH NEXT
   FROM PMSreindex
   into @object_name, @name, @esquema

   while @@FETCH_STATUS = 0
BEGIN
--listado de indices por reindexar
print 'indice por reindexar ' + @name +' de la tabla '+  @object_name
--ejecucion de la reindexacion
SELECT @gozalo = 'ALTER INDEX ['+ RTRIM (@name) + '] ON [' + @esquema + '].[' +  RTRIM (@object_name) + '] REORGANIZE WITH ( LOB_COMPACTION = ON )'
   exec (@gozalo)

--captura de errorres
   BEGIN TRY
    -- RAISERROR with severity 11-19 will cause execution to
    -- jump to the CATCH block.
    RAISERROR ('Error raised in TRY block.', -- Message text.
               16, -- Severity.
               1 -- State.
               );
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    -- Use RAISERROR inside the CATCH block to return error
    -- information about the original error that caused
    -- execution to jump to the CATCH block.
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH;

print @ErrorMessage
print @ErrorSeverity
print @ErrorState

 FETCH NEXT
   FROM PMSreindex
   into @object_name, @name, @esquema
end
-- cierre del cursor PMSreindex
CLOSE PMSreindex
DEALLOCATE PMSreindex

