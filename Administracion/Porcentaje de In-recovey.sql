
--ver estado de inrecovery 2005 >

DECLARE @DBName VARCHAR(64) 
SET @DBName = 'DWHGFBC_Hasta20161111'   

DECLARE @ErrorLog AS TABLE([LogDate] CHAR(24), [ProcessInfo] VARCHAR(64), [TEXT] VARCHAR(MAX))   

INSERT INTO @ErrorLog 
EXEC sys.xp_readerrorlog 0, 1, 'Recovery of database', @DBName   

SELECT TOP 10 	 [LogDate],
                 SUBSTRING([TEXT], CHARINDEX(') is ', [TEXT]) + 4, CHARINDEX(' complete (', [TEXT]) - CHARINDEX(') is ', [TEXT]) - 4) AS PercentComplete 	,
                 CAST(SUBSTRING([TEXT], CHARINDEX('approximately', [TEXT]) + 13,CHARINDEX(' seconds remain', [TEXT]) - CHARINDEX('approximately', [TEXT]) - 13) AS FLOAT)/60.0 AS MinutesRemaining 	,
                 CAST(SUBSTRING([TEXT], CHARINDEX('approximately', [TEXT]) + 13,CHARINDEX(' seconds remain', [TEXT]) - CHARINDEX('approximately', [TEXT]) - 13) AS FLOAT)/60.0/60.0 AS HoursRemaining 	,
                 [TEXT]   
   FROM @ErrorLog 
  ORDER BY [LogDate] DESC


--ver estado de inrecovery 2012
DECLARE @DBName VARCHAR(64) = 'DWHGFBC_Hasta20161111'   
DECLARE @ErrorLog AS TABLE([LogDate] CHAR(24), [ProcessInfo] VARCHAR(64), [TEXT] VARCHAR(MAX))   

INSERT INTO @ErrorLog 
EXEC master..sp_readerrorlog 0, 1, 'Recovery of database', @DBName   

SELECT TOP 5 	 [LogDate] 	,
                 SUBSTRING([TEXT], CHARINDEX(') is ', [TEXT]) + 4,CHARINDEX(' complete (', [TEXT]) - CHARINDEX(') is ', [TEXT]) - 4) AS PercentComplete 	,
                 CAST(SUBSTRING([TEXT], CHARINDEX('approximately', [TEXT]) + 13,CHARINDEX(' seconds remain', [TEXT]) - CHARINDEX('approximately', [TEXT]) - 13) AS FLOAT)/60.0 AS MinutesRemaining 	,
                 CAST(SUBSTRING([TEXT], CHARINDEX('approximately', [TEXT]) + 13,CHARINDEX(' seconds remain', [TEXT]) - CHARINDEX('approximately', [TEXT]) - 13) AS FLOAT)/60.0/60.0 AS HoursRemaining 	,
                 [TEXT]   
  FROM @ErrorLog 
 ORDER BY [LogDate] DESC