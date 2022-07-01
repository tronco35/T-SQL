USE [master]
GO

/****** Object:  Login [CORPBANCA\henry-troncoso]    Script Date: 8/11/2016 3:37:55 PM ******/
CREATE LOGIN [CORPBANCA\henry-troncoso] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [CORPBANCA\henry-troncoso]
GO
