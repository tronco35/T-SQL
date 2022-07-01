--verificar ubicacion de BD tamaño nombre logico e instancia
select CONVERT(sysname, SERVERPROPERTY('servername')) as Instancia, d.name as BaseDatos,
s.name as "nombre logico", (s.size*8)/1024 as Tamaño_MB, s.physical_name AS UbicacionFisica, 
d.state_desc as Estado, recovery_model_desc
from sys.databases as d
inner join  sys.master_files as s ON d.database_id = s.database_id 
