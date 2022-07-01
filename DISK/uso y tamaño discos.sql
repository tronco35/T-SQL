SELECT distinct SERVERPROPERTY ('ServerName') AS 'NOMBRE_INSTANCIA',
(volume_mount_point) as Unidad, 
  total_bytes/1048576 as Tamaño_MB, 
  available_bytes/1048576 as Libre_MB,
 cast ( (select ((available_bytes/1048576* 1.0)/(total_bytes/1048576* 1.0) *100))as int) as PorcentajeDisponible
FROM sys.master_files AS f CROSS APPLY 
  sys.dm_os_volume_stats(f.database_id, f.file_id)
group by volume_mount_point, total_bytes/1048576, 
  available_bytes/1048576 order by 1