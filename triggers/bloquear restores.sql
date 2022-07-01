

/************************************************
TGR_NoSSMS
c 2016/08/18 Henry Troncoso 
Bloquea el acceso de SSMS del usuario CS_Aranda8
Solo permite acceder desde el servidor de APP

*************************************************/
IF EXISTS (SELECT * FROM sys.triggers WHERE parent_class = 0 AND name = 'TGR_NoRestore')
DROP TRIGGER TGR_NoRestore ON ALL SERVER
go

CREATE TRIGGER TGR_NoRestore
ON ALL SERVER --WITH EXECUTE AS 'CS_Aranda8'  
FOR drop_DATABASE 
AS  
BEGIN  
IF 
    (
SELECT count (*)
FROM sys.dm_exec_requests AS r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
where text like 'restore database%'
)  > 0
ROLLBACK;  
END;  
  






--SELECT count (*)
--FROM sys.dm_exec_requests AS r
--CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
--where text like '%restore database%'


select * FROM sys.dm_exec_requests AS r