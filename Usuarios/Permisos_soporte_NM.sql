USE [master] 
GO
CREATE LOGIN [HFSG\NM18034] FROM WINDOWS WITH DEFAULT_DATABASE=[msdb]
GO
USE [msdb]
GO
CREATE USER [HFSG\NM18034] FOR LOGIN [HFSG\NM18034]
GO
USE [msdb]
GO
EXEC sp_addrolemember N'db_datareader', N'HFSG\NM18034'
GO
USE [msdb]
GO
EXEC sp_addrolemember N'db_ssisltduser', N'HFSG\NM18034'
GO
USE [msdb]
GO
EXEC sp_addrolemember N'SQLAgentReaderRole', N'HFSG\NM18034'
GO
USE [msdb]
GO
EXEC sp_addrolemember N'SQLAgentUserRole', N'HFSG\NM18034'
GO
