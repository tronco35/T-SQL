USE [master]
GO

/****** Object:  StoredProcedure [dbo].[sp_ConsultasActivas]    Script Date: 28/12/2016 10:46:02 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create PROC [dbo].[sp_ConsultasActivas]
AS
BEGIN
DECLARE @runtime datetime
SET @runtime = GETDATE()

--System Requests

SELECT @runtime as runtime,
       DB_NAME(database_id) AS database_name,
       dest.text AS [batch],
       SUBSTRING(dest.text, (der.statement_start_offset / 2) + 1, ((
       CASE 
            WHEN der.statement_end_offset < 1 THEN LEN(CONVERT(nvarchar(max), dest.text)) * 2
            ELSE der.statement_end_offset
       END - der.statement_start_offset) / 2) + 1) AS [statement],
	   deqp.query_plan,
       der.session_id,
       request_id,
       start_time,
       status,
       command,
       user_id,
       blocking_session_id,
       wait_type,
       wait_time,
       last_wait_type,
       wait_resource,
       open_transaction_count,
       open_resultset_count,
       transaction_id,
       percent_complete,
       estimated_completion_time,
       cpu_time,
       total_elapsed_time,
       scheduler_id,
       reads,
       writes,
       logical_reads,
       transaction_isolation_level,
       lock_timeout,
       deadlock_priority,
       row_count,
       prev_error,
       nest_level,
       granted_query_memory
FROM   sys.dm_exec_requests der
CROSS APPLY sys.dm_exec_sql_text (der.sql_handle) dest
OUTER APPLY sys.dm_exec_query_plan (der.plan_handle) deqp
WHERE  session_id <> @@SPID
END

GO


