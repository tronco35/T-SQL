 select j.name as JOBName--,s.*
 ,s.step_name , s.command
 from msdb.dbo.sysjobs as j inner join msdb.dbo.sysjobsteps as s ON j.job_id = s.job_id
 where s.subsystem = 'SSIS' and s.command like '%dtsx%'