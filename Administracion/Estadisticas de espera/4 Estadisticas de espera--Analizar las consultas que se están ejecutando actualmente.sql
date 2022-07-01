/*
 Analizar las consultas que se están ejecutando actualmente o que han ejecutado recientemente 
 y su plan todavía está en la caché.
 https://blog.sqlauthority.com/2011/02/04/sql-server-dmv-sys-dm_os_waiting_tasks-and-sys-dm_exec_requests-wait-type-day-4-of-28/
Puede cambiar CROSS APPLY por OUTER APPLY si desea ver todos los detalles que se 
omitieron debido a la caché del plan.

*/

SELECT dm_ws.wait_duration_ms,
dm_ws.wait_type,
dm_es.status,
dm_t.TEXT,
dm_qp.query_plan,
dm_ws.session_ID,
dm_es.cpu_time,
dm_es.memory_usage,
dm_es.logical_reads,
dm_es.total_elapsed_time,
dm_es.program_name,
DB_NAME(dm_r.database_id) DatabaseName,
-- Optional columns
dm_ws.blocking_session_id,
dm_r.wait_resource,
dm_es.login_name,
dm_r.command,
dm_r.last_wait_type
FROM sys.dm_os_waiting_tasks dm_ws
INNER JOIN sys.dm_exec_requests dm_r ON dm_ws.session_id = dm_r.session_id
INNER JOIN sys.dm_exec_sessions dm_es ON dm_es.session_id = dm_r.session_id
CROSS APPLY sys.dm_exec_sql_text (dm_r.sql_handle) dm_t --CROSS APPLY por OUTER APPLY
CROSS APPLY sys.dm_exec_query_plan (dm_r.plan_handle) dm_qp --CROSS APPLY por OUTER APPLY
WHERE dm_es.is_user_process = 1
GO

/*
wait_duration_ms
Indica la espera actual para la consulta que se ejecuta en ese momento.

wait_type
Indica el tipo de espera actual para la consulta

text 
Indica el texto de la consulta

query_plan
Cuando se hace clic en el mismo, se mostrarán los planos de consulta
*/