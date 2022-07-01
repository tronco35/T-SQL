--borra cache
DBCC FREEPROCCACHE

--listado de planes de ejecucion 
select * from sys.dm_exec_query_stats


--borrar un plan de ejecucion en especifico
DBCC FREEPROCCACHE(<plan_handle>) 

--eliminar cache de una base de datos en especifico
DBCC FLUSHPROCINDB(db_id) --no documentado

ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE 
Criteria for plan reuse --docuemntado  partir de SQL 2016