--ubicacion de ultimos backup
select s.backup_start_date, s.database_name, m.physical_device_name ,
s.name as NombreBackup,
datediff ( minute, s.backup_start_date , s.backup_finish_date) as "Min de ejejcusion de Backup"
from msdb.dbo.backupset 
as s inner join msdb.dbo.backupmediafamily as m ON s.media_set_id = m.media_set_id
where s.database_name in ('SerivaNetLimites') --base de datos que busco
--and physical_device_name like '\\boinfsqln3\Backups_Seriva_Produccion\AC%' -- ubicacion fisica
and s.type = 'D' -- I = diferencial / D = full -- si es diferencial o full
and backup_start_date between '2017-02-01 00:00:00.000' and '2017-02-02 00:00:00.000' --cuando inicio el backup
order by s.backup_start_date desc


--select * from msdb.dbo.backupset 





