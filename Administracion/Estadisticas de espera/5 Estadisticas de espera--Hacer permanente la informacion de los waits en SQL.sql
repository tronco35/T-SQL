/*
Hacer permanente la informacion de los waits en SQL
*/

-- Create Table
CREATE TABLE [MyWaitStatTable](
[wait_type] [nvarchar](60) NOT NULL,
[waiting_tasks_count] [bigint] NOT NULL,
[wait_time_ms] [bigint] NOT NULL,
[max_wait_time_ms] [bigint] NOT NULL,
[signal_wait_time_ms] [bigint] NOT NULL,
[CurrentDateTime] DATETIME NOT NULL,
[Flag] INT
)
GO
-- Populate Table at Time 1
INSERT INTO MyWaitStatTable
([wait_type],[waiting_tasks_count],[wait_time_ms],[max_wait_time_ms],[signal_wait_time_ms],
[CurrentDateTime],[Flag])
SELECT [wait_type],[waiting_tasks_count],[wait_time_ms],[max_wait_time_ms],[signal_wait_time_ms],
GETDATE(), 1
FROM sys.dm_os_wait_stats
GO
----- Desired Delay (for one hour) WAITFOR DELAY '01:00:00'
-- Populate Table at Time 2
INSERT INTO MyWaitStatTable
([wait_type],[waiting_tasks_count],[wait_time_ms],[max_wait_time_ms],[signal_wait_time_ms],
[CurrentDateTime],[Flag])
SELECT [wait_type],[waiting_tasks_count],[wait_time_ms],[max_wait_time_ms],[signal_wait_time_ms],
GETDATE(), 2
FROM sys.dm_os_wait_stats
GO
-- Check the difference between Time 1 and Time 2
SELECT T1.wait_type, T1.wait_time_ms Original_WaitTime,
T2.wait_time_ms LaterWaitTime,
(T2.wait_time_ms - T1.wait_time_ms) DiffenceWaitTime
FROM MyWaitStatTable T1
INNER JOIN MyWaitStatTable T2 ON T1.wait_type = T2.wait_type
WHERE T2.wait_time_ms > T1.wait_time_ms
AND T1.Flag = 1 AND T2.Flag = 2
ORDER BY DiffenceWaitTime DESC
GO
-- Clean up
DROP TABLE MyWaitStatTable
GO