IF OBJECT_ID('tempdb..#info') IS NOT NULL
drop table #info 

create table #info 
(info  nvarchar (100))

if (
SELECT value
FROM master.sys.configurations WHERE name= 'xp_cmdshell') = 1
insert into #info (info)
exec xp_cmdshell 'systeminfo | findstr /c:"System Manufacturer:"'

if (
SELECT value
FROM master.sys.configurations WHERE name= 'xp_cmdshell') = 1
insert into #info (info)
exec xp_cmdshell 'systeminfo | findstr /c:"System Model:"'
  
IF OBJECT_ID('tempdb..#bd') IS NOT NULL
drop table #bd
 
 select cast ( SERVERPROPERTY ('MachineName')as nvarchar) AS 'BD'
 into #bd


select d.name AS 'NOMBRE_CI',
   dd.state_desc AS 'ESTADO_ACTUAL',
  case  when (select info from #info) = null then 'No activo xp_cmdShell'
else (select ltrim (replace (info, 'System Manufacturer:' , '' )) as Fabricante from #info where info like 'System Manufacturer%')
end as Fabricante
   ,
   case 
when (select info from #info) = null then 'No activo xp_cmdShell'
else (select ltrim (replace (info, 'System Model:' , '' )) as Fabricante from #info where info like 'System Model%')
end as Modelo,
   
  CASE   LEFT(CONVERT(VARCHAR,SERVERPROPERTY ('ProductVersion')),PATINDEX ( '%.%' , CONVERT(VARCHAR,SERVERPROPERTY ('ProductVersion') ))-1)
   --PATINDEX ( '%.%' , CONVERT(VARCHAR,SERVERPROPERTY ('ProductVersion') ))
   WHEN 8 THEN 'SQLServer_2000'
   WHEN 9 THEN 'SQLServer_2005'
   WHEN 10 THEN 'SQLServer_2008_R2'
   WHEN 11 THEN 'SQLServer_2012'
   WHEN 12 THEN 'SQLServer_2014'
   ELSE 'SQLServer_(Otro)'
   end AS 'MOTOR_BD',
   SERVERPROPERTY ('ProductVersion') AS 'VERSION_MOTOR',
SERVERPROPERTY ('ProductLevel') AS 'SERVICEPACK_MOTOR',

d.cmptlevel AS 'COMPATIBILIDAD_BD',
dd.recovery_model_desc AS 'MODELO_RECUPERACION_BD',

   m.size AS 'TAMAÑO_BD_(MB)',
     SERVERPROPERTY ('MachineName') AS 'SERVIDOR_BD',



SERVERPROPERTY ('ServerName') AS 'NOMBRE_INSTANCIA',


   CONVERT(nvarchar(10), d.crdate, 103) AS 'FECHA_ENTRADA',
  --FECHA ENTRADA




(SELECT top 1 local_net_address FROM sys.dm_exec_connections WHERE local_net_address IS NOT NULL) AS 'IP_SERVIDOR',
(SELECT top 1 local_tcp_Port FROM sys.dm_exec_connections WHERE local_net_address IS NOT NULL) AS 'PUERTO',


CASE
   WHEN SERVERPROPERTY ('IsHadrEnabled')=1 THEN 'Always_On'
   WHEN SERVERPROPERTY ('IsClustered')=1 THEN 'Failover_Cluster'
   ELSE 'No Tiene Alta Disponibilidad'
   end AS 'ALTA_DISPONIBILIDAD'

 , case
 when  (select virtual_machine_type from  sys.dm_os_sys_info ) = 1 then 'Virtual'
 else 'Equipo Fisico'
 end as "Tipo de Equipo"

 ,case 
when  (select cast (bd as nvarchar) from #bd) like 'BOINFSQL%' THEN 'Produccion'
when  (select cast (bd as nvarchar) from #bd) like 'BOINFSQC%' THEN 'Ambientes Previos'
ELSE '--'
END as Ambiente

 , user_access_desc as "ESTADO ACCESO BD"
 from master.dbo.sysdatabases d
left join (select database_id, sum(size*8/1024) as size from sys.master_files group by  database_id) m on 
   d.dbid = m.database_id
left join sys.databases dd on 
   d.dbid = dd.database_id
  where dbid > 4






