USE [master]
GO

--desatachar db
ALTER DATABASE CTX_Logg_Test76
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;

ALTER DATABASE CTX_Logg_Test76
SET MULTI_USER
GO
 
EXEC master.dbo.sp_detach_db @dbname = N'CTX_Logg_Test76'

--atachar db
EXEC sp_attach_db @dbname = N'CTX_Logg_Test76',   
    @filename1 =   
N'M:\Databases\BOINFSQC9\DATA\CTX_Logg_Test76.mdf',   
    @filename2 =   
N'M:\Databases\BOINFSQC9\log\CTX_Logg_Test76_log.LDF';

--VER

--select  d.name as BaseDatos,
--s.name as "nombre logico", (s.size*8)/1024 as Tamaño_MB, s.physical_name AS UbicacionFisica
--from sys.databases as d
--inner join  sys.master_files as s ON d.database_id = s.database_id 
--left join (select rank () over (PARTITION BY database_name order by  backup_finish_date desc ) as [Ranking], 
--database_name ,name, backup_finish_date
--from msdb.dbo.backupset) as bk ON d.name = bk.database_name and bk.Ranking = 1
--where  s.physical_name LIKE 'C:\%'