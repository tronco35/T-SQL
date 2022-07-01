
 IF OBJECT_ID('tempdb..#bd') IS NOT NULL
drop table #bd

 select cast ( SERVERPROPERTY ('MachineName')as nvarchar) AS 'BD'
 into #bd

 select 
 cast ( SERVERPROPERTY ('MachineName')as nvarchar) AS 'SERVIDOR_BD',
 SERVERPROPERTY ('ServerName') AS 'NOMBRE_INSTANCIA',
 d.name as BD,
 dd.state_desc AS 'ESTADO_ACTUAL',
  CASE   LEFT(CONVERT(VARCHAR,SERVERPROPERTY ('ProductVersion')),PATINDEX ( '%.%' , CONVERT(VARCHAR,SERVERPROPERTY ('ProductVersion') ))-1)
   --PATINDEX ( '%.%' , CONVERT(VARCHAR,SERVERPROPERTY ('ProductVersion') ))
   WHEN 8 THEN 'SQLServer_2000'
   WHEN 9 THEN 'SQLServer_2005'
   WHEN 10 THEN 'SQLServer_2008'
   WHEN 11 THEN 'SQLServer_2012'
   WHEN 12 THEN 'SQLServer_2014'
   WHEN 13 THEN 'SQLServer_2016'
   when  14 then 'SQL Server 2017'
   ELSE 'SQLServer_(Otro)'
   end AS 'MOTOR_BD',
   SERVERPROPERTY ('ProductVersion') AS 'VERSION_MOTOR',
SERVERPROPERTY ('ProductLevel') AS 'SERVICEPACK_MOTOR',

case 
d.cmptlevel 
   WHEN 80 THEN 'SQLServer_2000'
   WHEN 90 THEN 'SQLServer_2005'
   WHEN 100 THEN 'SQLServer_2008'
   WHEN 110 THEN 'SQLServer_2012'
   WHEN 120 THEN 'SQLServer_2014'
    WHEN 130 THEN 'SQLServer_2016'
   when  140 then 'SQL Server 2017'
   ELSE 'SQLServer_(Otro)'
   end
AS 'COMPATIBILIDAD_BD',
dd.recovery_model_desc AS 'MODELO_RECUPERACION_BD',

   m.size AS 'TAMAÑO_BD_(MB)',


   CONVERT(nvarchar(10), d.crdate, 103) AS 'FECHA_ENTRADA',
  --FECHA ENTRADA

(SELECT top 1 local_net_address FROM sys.dm_exec_connections WHERE local_net_address IS NOT NULL) AS 'IP_SERVIDOR',
(SELECT top 1 local_tcp_Port FROM sys.dm_exec_connections WHERE local_net_address IS NOT NULL) AS 'PUERTO',


CASE
   WHEN SERVERPROPERTY ('IsHadrEnabled')=1 THEN 'Always_On'
   WHEN SERVERPROPERTY ('IsClustered')=1 THEN 'Failover_Cluster'
   ELSE 'No Tiene Alta Disponibilidad'
   end AS 'ALTA_DISPONIBILIDAD'




 , user_access_desc as "ESTADO ACCESO BD"
 ,collation_name as CollationBD
 ,CONVERT (varchar, SERVERPROPERTY('collation')) CollationInstance
 from master.dbo.sysdatabases d
left join (select database_id, sum(size*8/1024) as size from sys.master_files group by  database_id) m on 
   d.dbid = m.database_id
left join sys.databases dd on 
   d.dbid = dd.database_id





