select
distinct (Database_name),
cast ((compressed_backup_size / 1024) /1024 as int) as TamañoMB, backup_start_date,
datediff ( minute, s.backup_start_date , s.backup_finish_date) as "Tiempo de Ejecucion de Backup MIN"
from msdb.dbo.backupset 
as s inner join msdb.dbo.backupmediafamily as m ON s.media_set_id = m.media_set_id
where  
physical_device_name  like 'Z:\%' --and Database_name = 'ParadocMail_MT_trans'
order by backup_start_date
