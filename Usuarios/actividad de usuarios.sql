
SELECT s.session_id, s.[login_name] , s.login_time, s.[host_name], d.name as BaseDatos
,s.[status],
text as Sentencia, r.start_time as "Inicio de Sentencia" ,
s.Program_name 
FROM sys.dm_exec_sessions as s left join sys.dm_exec_requests AS r ON s.session_id = r.session_id
outer APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
inner join sys.databases as d ON r.database_id = d.database_id
where  s.[login_name] is not null
order by text desc, s.login_time desc

--Status significado
--Running: está ejecutando una o varias solicitudes actualmente
--Sleeping: no está ejecutando solicitudes actualmente
--Dormant: la sesión se ha restablecido debido a que la agrupación de conexiones está ahora ---en estado previo al inicio de sesión.
--Preconnect: la sesión está en el clasificador del regulador de recursos.




