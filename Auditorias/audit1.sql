USE [msdb]
GO

/****** Object:  Job [DBAJOB - Export_Auditoria_BD_TXT]    Script Date: 26/12/2016 03:43:26 p.m. ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 26/12/2016 03:43:26 p.m. ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBAJOB - Export_Auditoria_BD_TXT', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'HFSG\AL11788', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Generar TXT]    Script Date: 26/12/2016 03:43:26 p.m. ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Generar TXT', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @DateDate datetime
declare @tracefile nvarchar(128)
declare @tracename nvarchar(128)
declare @tracedir nvarchar(128)
declare @apliname nvarchar(128)
declare @cmd nvarchar(4000)
declare @tracesalida nvarchar(128)
declare @salida nvarchar(4000)
declare @cont int
declare @diasatras int

--set @diasatras = -57
--select CONVERT(VARCHAR(8), DATEADD(DAY, @diasatras, GETDATE()), 112)

--print @diasatras


DECLARE subscripciones CURSOR
    FOR   SELECT [filename]
      ,[path]
      ,[apliname]
  FROM [DBA_Admin].[dbo].[tblDBA_SuscripcionesAudit]
OPEN subscripciones
FETCH NEXT FROM subscripciones INTO @tracename,  @tracedir, @apliname
WHILE @@FETCH_STATUS = 0
BEGIN

set @diasatras = -1
set @tracedir = @tracedir + ''\''

WHILE (@diasatras < 0)
BEGIN
-- set @tracedir = ''B:\backups\Seriva''

  set @tracesalida = ltrim(rtrim(ltrim(rtrim(@tracedir)) + ltrim(rtrim(@tracename)) + CONVERT(VARCHAR(8), DATEADD(DAY, @diasatras, GETDATE()), 112))) + ''.txt'' -- convert(varchar(8),getdate(),112))) --+

  set @cmd = ''SQLCMD -S BOINFSQL11 -E -d DBA_Admin -Q "exec spDBA_AuditMesOnline_txt '''''' + CONVERT(VARCHAR(8), DATEADD(DAY, @diasatras , GETDATE()), 112) + '''''', ''''''
  set @cmd = @cmd + LTRIM(RTRIM(@apliname)) + ''''''''
  set @cmd = @cmd + ''" -h -1 -u -o '' + LTRIM(RTRIM(@tracesalida))
  --print @cmd
  exec @salida = master..xp_cmdshell @cmd
set @diasatras =  @diasatras + 1
END

--select @salida
  FETCH NEXT FROM subscripciones INTO @tracename,  @tracedir, @apliname
END
CLOSE subscripciones
DEALLOCATE subscripciones

', 
		@database_name=N'impuestos', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'export_aud_diaria_otros_dias', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20161215, 
		@active_end_date=99991231, 
		@active_start_time=140000, 
		@active_end_time=235959, 
		@schedule_uid=N'679af5bb-5f6a-4e7e-b708-f42f4cf77e01'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


