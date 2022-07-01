--estado de memoria
SELECT  SERVERPROPERTY ('ServerName') AS 'NOMBRE_INSTANCIA',
(select  value FROM sys.configurations WHERE configuration_id =1543) as MemoriaMINAsignada,
(select  value FROM sys.configurations WHERE configuration_id =1544) as MemoriaMAXAsignada,
(physical_memory_in_use_kb/1024) AS MemoriaUtilizada_MB,
100 *  cast ((physical_memory_in_use_kb/1024)as int)/
cast ((select  value FROM sys.configurations WHERE configuration_id =1544)as int ) as PorcetajeMemoriaUtilizada
FROM sys.dm_os_process_memory;