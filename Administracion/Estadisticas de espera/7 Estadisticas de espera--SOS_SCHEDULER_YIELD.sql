--SOS_SCHEDULER_YIELD
/*
SQL Server tiene varios subprocesos, y la metodolog�a b�sica de trabajo para SQL Server es que SQL 
Server no permite que cualquier hilo "runnable" fallece. Ahora supongamos que el sistema operativo de SQL 
Server est� muy ocupado ejecutando subprocesos en todo el planificador. 
Siempre hay nuevos temas pr�ximos que est�n listos para ejecutarse (en otras palabras, ejecutables). 
La administraci�n de subprocesos de SQL Server es decidida por SQL Server y no por el sistema operativo. 
SQL Server se ejecuta en modo no preemptivo la mayor parte del tiempo, lo que significa que los subprocesos 
son cooperativos y pueden permitir que otros subprocesos se ejecuten de vez en cuando produci�ndose. 
Cuando cualquier hilo se produce por otro hilo, crea esta espera. Si hay m�s hilos, indica claramente que 
la CPU est� bajo presi�n.
*/

/*
Si nota un n�mero de dos d�gitos en runnable_tasks_count continuamente durante mucho tiempo (no 
de vez en cuando), sabr� que hay presi�n de la CPU. El n�mero de dos d�gitos se considera generalmente 
como algo malo
lance la siguiente query
*/
SELECT scheduler_id, current_tasks_count, runnable_tasks_count, work_queue_count, pending_disk_io_count
FROM sys.dm_os_schedulers
WHERE scheduler_id < 255
GO

/*

Esta es la parte m�s complicada de este procedimiento. Como se ha comentado, este tipo de espera particular
 se refiere a la presi�n de la CPU. Aumentar m�s CPU es la soluci�n en t�rminos simples; Sin embargo, no es 
 f�cil implementar esta soluci�n. Hay otras cosas que usted puede considerar cuando este tipo de espera es
 muy alto. Aqu� est� la consulta donde puede encontrar la consulta m�s cara relacionada con la CPU de la 
 cach�

 preste atenci�n a total_worker_time porque si eso tambi�n es consistentemente mayor, entonces la CPU bajo 
 demasiada presi�n.

*/


SELECT SUBSTRING(qt.TEXT, (qs.statement_start_offset/2)+1,
((CASE qs.statement_end_offset
WHEN -1 THEN DATALENGTH(qt.TEXT)
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2)+1),
qs.execution_count,
qs.total_logical_reads, qs.last_logical_reads,
qs.total_logical_writes, qs.last_logical_writes,
qs.total_worker_time,
qs.last_worker_time,
qs.total_elapsed_time/1000000 total_elapsed_time_in_S,
qs.last_elapsed_time/1000000 last_elapsed_time_in_S,
qs.last_execution_time,
qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY qs.total_worker_time DESC -- CPU time

/*
 Advertancia:
 aumentar el numero de hilos soluciona el inconveniente,pero se debe probar previemente en pruebas
*/