USE master;  
GO  

alter database ReportesTesorerķa_Soporte set single_user
WITH ROLLBACK IMMEDIATE;
go
ALTER DATABASE ReportesTesorerķa_Soporte 
Modify Name = ReportesTesoreria_Soporte ;  
GO  

alter database ReportesTesoreria_Soporte set multi_user
go