/********************************************************
Mantenimiento SDefrag y estadisticas versiones 2012
Corregido Henry Troncoso 
*********************************************************/
--SOLO VERSIONES 2012 EN ALWAYSON QUIATAR LOS COMENTARIOS
--IF (SELECT COUNT(*)
--FROM sys.dm_hadr_availability_group_states 
--WHERE @@SERVERNAME=primary_replica) =1





BEGIN

	DECLARE @RebuildThreshold INT
	DECLARE @ReorganizeThreshold INT


	---------------------------------------------------------------
	-- VARIABLES TO CHANGE --
	---------------------------------------------------------------

	SELECT @RebuildThreshold = 30
	SELECT @ReorganizeThreshold = 5

	---------------------------------------------------------------
	---------------------------------------------------------------

	DECLARE @objectid INT
	DECLARE @indexid INT
	DECLARE @partitioncount bigint
	DECLARE @schemaname VARCHAR(130)
	DECLARE @objectname VARCHAR(130)
	DECLARE @indexname VARCHAR(130)
	DECLARE @indextype INT
	DECLARE @partitionnum bigint
	DECLARE @partitions bigint
	DECLARE @frag INT
	DECLARE @command VARCHAR(4000)
	DECLARE @max INT
	DECLARE @min INT
	DECLARE @DB_ID INT
	DECLARE @DB_NAME NVARCHAR(128)
	DECLARE @IndexListCount INT
	DECLARE @Edition NVARCHAR(100)

	DECLARE @LobCount INT
	SELECT @LobCount = 0
	SELECT @DB_ID = DB_ID()
	SELECT @DB_NAME = DB_NAME()
	SELECT  @Edition = CONVERT(NVARCHAR(100), SERVERPROPERTY ('edition')) 

	CREATE TABLE #BenchmarkIndexList (ID INT IDENTITY(1,1), 
	   DBName VARCHAR(100), 
	   objectID INT,
	   indexID INT,
	   IndexType VARCHAR(30),
	   frag INT,
	   avg_frag_size_pages INT,
	   page_count INT,
	   partition_number INT)

	CREATE CLUSTERED INDEX IX_CL_IndexList ON #BenchmarkIndexList(ID)

	INSERT #BenchmarkIndexList (DBName, objectID, indexID, IndexType, frag, 
					   avg_frag_size_pages, page_count, partition_number)
	SELECT DB_NAME(database_id) AS DBName, OBJECT_ID, index_id, index_type_desc AS 'IndexType',
		   avg_fragmentation_in_percent, avg_fragment_size_in_pages, page_count, partition_number
	FROM   sys.dm_db_index_physical_stats (@DB_ID, NULL, NULL, NULL, 'LIMITED')
	WHERE  page_count > 10 AND 
		   index_id > 0 AND 
		   index_type_desc NOT LIKE '%XML%' 
       
	SELECT @IndexListCount = COUNT(1) FROM #BenchmarkIndexList

	SELECT @max = (SELECT MAX(ID) FROM #BenchmarkIndexList)
	SELECT @min = 1
	WHILE @min <= @max
	BEGIN

		SET @command = NULL

	   SELECT  @objectid = objectID, @indexid = indexID, @partitionnum = partition_number, @frag = frag
	   FROM    #BenchmarkIndexList
	   WHERE   ID = @min

	   SELECT  @objectname = o.name, @schemaname = s.name
	   FROM    sys.objects AS o JOIN 
			   sys.schemas AS s ON s.schema_id = o.schema_id
	   WHERE   o.OBJECT_ID = @objectid

	   SELECT  @indexname = name, @indextype = TYPE
	   FROM    sys.indexes
	   WHERE   OBJECT_ID = @objectid AND 
			   index_id = @indexid;

	   SELECT  @partitioncount = COUNT(1)
	   FROM    sys.partitions
	   WHERE   OBJECT_ID = @objectid AND 
			   index_id = @indexid
       
	   SELECT  @LobCount = COUNT(1)
	   FROM    sys.index_columns A INNER JOIN
			   sys.columns B ON A.OBJECT_ID = B.OBJECT_ID AND A.Column_id = B.Column_ID INNER JOIN
			   sys.types C ON B.system_type_id = C.user_type_id
	   WHERE   A.OBJECT_ID = @objectID AND
			   A.index_id = @indexID AND 
			   (C.name IN('xml','image','text','ntext') OR
			   (C.name IN('varchar','nvarchar','varbinary','nvarbinary') AND 
			   B.max_length = -1))

	   IF @frag >= @ReorganizeThreshold  and @frag < @RebuildThreshold 
		   SET @command = 'ALTER INDEX [' + @indexname + '] ON [' + @schemaname + '].[' + @objectname + '] REORGANIZE';

	   IF @frag >= @RebuildThreshold
		IF @LobCount = 0 
		   SET @command = 'ALTER INDEX [' + @indexname + '] ON [' + @schemaname + '].[' + @objectname +'] REBUILD WITH(ONLINE = ON, SORT_IN_TEMPDB = ON)';
		ELSE
		   SET @command = 'ALTER INDEX [' + @indexname + '] ON [' + @schemaname + '].[' + @objectname +'[ REBUILD WITH(ONLINE = OFF, SORT_IN_TEMPDB = ON)';

		IF @objectname not like '%_#%' and @command is not NULL
		begin
			print   @command
			--EXEC (@command)
		end

		IF @frag < @RebuildThreshold
		BEGIN 
		   SET @command = ' UPDATE STATISTICS [' + @schemaname + '].[' + @objectname + ']([' + @indexname + ']) WITH FULLSCAN';
		  print   @command
		  --EXEC (@command)
	   END

	   SET @min = @min+1

	END

	DROP TABLE #BenchmarkIndexList
END
