select s.database_name as BaseDatos, 
user_name,
case 
when s.type = 'D' then 'Completo'
when s.type = 'I' then 'Diferencial'
when s.type = 'L' then 'Transaccional'
when s.type = 'F' then 'Archivo o filegroup'
when s.type = 'G' then 'Differential file'
when s.type = 'P' then 'Parcial'
when s.type = 'Q' then 'Parcial Diferencial'
else s.type
end as TipoBackup
,s.backup_start_date
, m.physical_device_name as Ruta
,datediff ( minute, s.backup_start_date , s.backup_finish_date) as "Min de ejejcusion de Backup",
s.name as NombreBackup
,is_copy_only
from msdb.dbo.backupset 
as s inner join msdb.dbo.backupmediafamily as m ON s.media_set_id = m.media_set_id
order by s.database_name, s.backup_start_date desc


--select user_name, * from msdb.dbo.backupset 