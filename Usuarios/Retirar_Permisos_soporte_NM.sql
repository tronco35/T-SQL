EXEC msdb.dbo.sp_attach_schedule @job_id=N'167366ec-419d-455a-bc3b-1a8db4fcac90',@schedule_id=322
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_schedule @schedule_id=322, 
		@enabled=1, 
		@active_start_date=20160808
GO
