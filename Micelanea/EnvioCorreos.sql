EXEC msdb.dbo.sp_send_dbmail  
    @profile_name = 'NotificacionesBD@paradocmail.com',  
    @recipients = 'henry.troncoso@bit-c.com.co; Laura.roncancio@bit-c.com.co; infraestructura@paradigma.com.co',  
    @query = 'select ''Falla JOB '' + ''BackupFull'' 
	+ '' de la instancia '' + CAST( SERVERPROPERTY (''ServerName'') as nvarchar)
	' ,  
    @subject = 'Job Fallido'  
	,@body = 'Fallo JOB informar de inmediato a BIT-C  
	DBA Henry Troncoso Valencia 310 285 40 88 
	Fredy Camargo 302 320 44 63'



