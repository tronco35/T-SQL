
SELECT TOP 10
    DB_NAME(qt.dbid) 'Base de Datos',
    OBJECT_NAME(qt.objectid,qt.dbid)AS 'Nombre Objeto',
    SUBSTRING(qt.text, (qs.statement_start_offset/2)+1,
    ((CASE qs.statement_end_offset
    WHEN -1 THEN DATALENGTH(qt.text)
    ELSE qs.statement_end_offset
    END - qs.statement_start_offset)/2)+1) AS 'Texto',
    qs.execution_count AS 'Veces ejecutado',
    qs.total_logical_reads AS 'Total lecturas lógicas',
    qs.last_logical_reads AS 'Lecturas lógicas del último proceso',
    qs.total_logical_writes AS 'Total escrituras lógicas',
    qs.last_logical_writes AS 'Escrituras lógicas del último proces',
    qs.total_worker_time AS 'Total tiempo CPU',
    qs.last_worker_time AS 'Tiempo CPU del último proceso',
    qs.min_worker_time AS 'Minimo tiempo CPU',
    qs.max_worker_time AS 'Maximo tiempo CPU',
    qs.total_elapsed_time/1000000 AS 'Total tiempo (en seg)',
    qs.last_elapsed_time/1000000 AS 'Tiempo del último proceso (en seg)',
    qs.min_elapsed_time/1000000 AS 'Tiempo mínimo (en seg)',
    qs.max_elapsed_time/1000000 AS 'Tiempo máximo (en seg)',
    qs.last_execution_time AS 'Ultima vez que se ejecutó',
    qp.query_plan AS 'Plan de ejecución'
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
--WHERE DB_NAME(qt.dbid) = 'NOMBRE_DE_BD'
ORDER BY qs.total_elapsed_time DESC
