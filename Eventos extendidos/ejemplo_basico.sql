CREATE EVENT SESSION QueryPerformance ON SERVER
ADD EVENT sqlserver.rpc_completed (
 WHERE (sqlserver.database_name = N'AdventureWorks2014')),
ADD EVENT sqlserver.sql_batch_completed (
 WHERE (sqlserver.database_name = N'AdventureWorks2014'))
ADD TARGET package0.event_file (SET filename = N'QueryPerformance')
WITH (MAX_MEMORY = 4096 KB,
 EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
 MAX_DISPATCH_LATENCY = 3 SECONDS,
 MAX_EVENT_SIZE = 0 KB,
 MEMORY_PARTITION_MODE = NONE,
 TRACK_CAUSALITY = OFF,
 STARTUP_STATE = OFF);