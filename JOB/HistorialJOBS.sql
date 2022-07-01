SELECT a.name as NameJob, 
case
when b.last_run_outcome = 0 then 'Fallo'
when b.last_run_outcome = 1 then 'Exitoso'
when b.last_run_outcome = 2 then 'reintento'
when b.last_run_outcome = 3 then 'Candelado'
when b.last_run_outcome = 4 then 'en ejecucion'
when b.last_run_outcome = 5 then 'Desconocido'
end
as ultimaEjecucion, 
enabled as Habilitado
,a.description as DescripcionJob
,c.step_name
,c.command
,
case
when c.last_run_outcome = 0 then 'Fallo'
when c.last_run_outcome = 1 then 'Exitoso'
when c.last_run_outcome = 2 then 'reintento'
when c.last_run_outcome = 3 then 'Candelado'
when c.last_run_outcome = 4 then 'en ejecucion'
when c.last_run_outcome = 5 then 'Desconocido'
end as ejecucionStep,
c.last_run_date,
c.last_run_time,
d.next_run_date,
next_run_time
FROM msdb.dbo.sysjobs A inner join msdb.dbo.sysjobservers B ON a.job_id = b.job_id
inner join msdb.dbo.sysjobsteps as c On a.job_id = c.job_id inner join msdb.dbo.sysjobschedules as d
On a.job_id = d.job_id
order by  c.last_run_date desc , a.name 
