USE master;  
GO  

alter database ReportesTesorer�a_Soporte set single_user
WITH ROLLBACK IMMEDIATE;
go
ALTER DATABASE ReportesTesorer�a_Soporte 
Modify Name = ReportesTesoreria_Soporte ;  
GO  

alter database ReportesTesoreria_Soporte set multi_user
go