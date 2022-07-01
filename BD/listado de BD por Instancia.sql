
--listado de BD por instancia + ubicacion
select CONVERT(sysname, SERVERPROPERTY('servername')) as Instancia, d.name  as Base, s.name as "nombre logico",
s.physical_name, d.state_desc
from sys.databases as d inner join  sys.master_files as s ON d.database_id = s.database_id
where d.name not in ('master', 'msdb', 'model', 'tempdb')
order by d.state_desc


--solo bd
select CONVERT(sysname, SERVERPROPERTY('servername')) as Instancia, d.name  as Base,
d.state_desc
from sys.databases as d 
where d.name not in ('master', 'msdb', 'model', 'tempdb')
order by d.state_desc