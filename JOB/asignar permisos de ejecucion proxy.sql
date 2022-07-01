asignar permisos de ejecucion proxy

USE msdb ;  
GO  
  
EXEC dbo.sp_grant_login_to_proxy  
    @login_name = N'PrBI',  
    @proxy_name = N'RunETL' ;  
GO  