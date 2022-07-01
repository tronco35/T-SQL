--RESTORE FILELISTONLY FROM DISK = '\\boinfsql6\backup\boinfsql6_dbOyD_Cival.bak'; select * from dboyd.sys.sysfiles
--RESTORE FILELISTONLY FROM DISK = '\\boinfsql6\backup\boinfsql6_dbA2UtilsCival.bak'; select * from dbEncuenta.sys.sysfiles
--RESTORE FILELISTONLY FROM DISK = '\\boinfsql6\backup\boinfsql6_dbSafyr.bak'; select * from dbSafyr.sys.sysfiles
--exec sp_who kill 56; kill 57; kill 59; kill 61; kill 62

USE [master]
GO
ALTER DATABASE [dbAlianza] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbAlianza] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbAlianza] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbAlianza.bak' WITH  FILE = 1,
--  MOVE N'dbAlianza_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Data.mdf',
--  MOVE N'dbAlianza_Indices' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Idx.ndf',
-- MOVE N'dbAlianza_log' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO

ALTER DATABASE [dbAlianzaUtilidades_v10] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbAlianzaUtilidades_v10] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbAlianzaUtilidades_v10] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbAlianzaUtilidades_v10.bak' WITH  FILE = 1,
--  MOVE N'dbAlianzaUtilidades_v10_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Data.mdf',
--  MOVE N'dbAlianza_Indices' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Idx.ndf',
-- MOVE N'dbAlianza_log' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO


ALTER DATABASE [dbApts] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbApts] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbApts] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_DbApts.bak' WITH  FILE = 1,
--  MOVE N'DbSafyrFondos' TO N'L:\Databases\BOINFSQC9\NBL\dbApts.mdf',
--  MOVE N'DbSafyrFondos_log' TO N'L:\Databases\BOINFSQC9\NBL\dbApts_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO
ALTER DATABASE [dbEncuenta] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbEncuenta] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbEncuenta] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbEncuenta.bak' WITH  FILE = 1,
  --MOVE N'dbContabilidad_ECA_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbEncuenta.mdf',
  --MOVE N'dbContabilidad_ECA_log' TO N'L:\Databases\BOINFSQC9\NBL\dbEncuenta_log.ldf',
  --MOVE N'dbContabilidad_ECA01_Data' TO N'F:\DatabaseFaseII\Alianza\dbEncuenta01.ndf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO
ALTER DATABASE [dbA2UtilsEncuenta] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbA2UtilsEncuenta] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbA2UtilsEncuenta] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbA2UtilsEncuenta.bak' WITH  FILE = 1,
--  MOVE N'dbAlianza_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Data.mdf',
--  MOVE N'dbAlianza_Indices' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Idx.ndf',
-- MOVE N'dbAlianza_log' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO

ALTER DATABASE [dbOyD] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbOyD] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbOyD] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbOyD.bak' WITH  FILE = 1,
--  MOVE N'dbOyDPruebas_Data'   TO N'E:\DatabaseFaseII\Alianza\dbOyD_Data.mdf',
--  MOVE N'dbOyDPruebas_Dta01'  TO N'G:\DatabaseFaseII\Alianza\dbOyD_01.ndf',
--  MOVE N'dbOyDPruebas_Log'    TO N'E:\DatabaseFaseII\Alianza\dbOyD_log.ldf',
--  MOVE N'dbOyDPruebas_Data01' TO N'G:\DatabaseFaseII\Alianza\dbOyD_Data01.ndf',
--  MOVE N'dbOyDPruebas_Data02' TO N'E:\DatabaseFaseII\Alianza\dbOyD_Data02.ndf',
  NOUNLOAD,  REPLACE,  STATS = 10
GO
-- I:\Ambiente QA DB\dbOyD
ALTER DATABASE [dbOyD_Cival] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbOyD_Cival] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbOyD_Cival] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbOyD_Cival.bak' WITH  FILE = 1,
--  MOVE N'dbOyD_Data'   TO N'I:\Ambiente QA DB\dbOyD\dbOyD_Cival_Data.mdf',
--  MOVE N'dbOyDPruebas_Dta01'  TO N'G:\DatabaseFaseII\Alianza\dbOyD_01.ndf',
--  MOVE N'dbOyD_Log'    TO N'I:\Ambiente QA DB\dbOyD\dbOyD_Cival_log.ldf',
--  MOVE N'dbOyDPruebas_Data01' TO N'G:\DatabaseFaseII\Alianza\dbOyD_Data01.ndf',
--  MOVE N'dbOyDPruebas_Data02' TO N'E:\DatabaseFaseII\Alianza\dbOyD_Data02.ndf',
  NOUNLOAD,  REPLACE,  STATS = 10
GO
ALTER DATABASE [dbA2Utils] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbA2Utils] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbA2Utils] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbA2Utils.bak' WITH  FILE = 1,
--  MOVE N'dbAlianza_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Data.mdf',
--  MOVE N'dbAlianza_Indices' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Idx.ndf',
-- MOVE N'dbAlianza_log' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO
ALTER DATABASE [dbA2UtilsCival] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbA2UtilsCival] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbA2UtilsCival] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbA2UtilsCival.bak' WITH  FILE = 1,
--  MOVE N'dbA2Utilidades_v40_Data' TO N'I:\Ambiente QA DB\dbOyD\dbA2UtilsCival_Data.mdf',
--  MOVE N'dbAlianza_Indices' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Idx.ndf',
-- MOVE N'dbA2Utilidades_v40_Log' TO N'I:\Ambiente QA DB\dbOyD\dbA2UtilsCival_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO

ALTER DATABASE [dbSafyr] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbSafyr] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbSafyr] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_DbSafyr.bak' WITH  FILE = 1,
--  MOVE N'DbSafyrFondos' TO N'L:\Databases\BOINFSQC9\NBL\dbSafyr.mdf',  
--  MOVE N'DbSafyrFondos_log' TO N'L:\Databases\BOINFSQC9\NBL\dbSafyr_log.ldf',
--  MOVE N'DbSaryrFondos01' TO N'F:\DatabaseFaseII\Alianza\dbSafyr_Data01.ndf',  
    NOUNLOAD,  REPLACE,  STATS = 10
GO
ALTER DATABASE [dbSafyrFormatos] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbSafyrFormatos] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbSafyrFormatos] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbSafyrFormatos.bak' WITH  FILE = 1,
  --MOVE N'dbSafyrFormatos' TO N'L:\Databases\BOINFSQC9\NBL\dbSafyrSF.mdf',  
  --MOVE N'dbSafyrSF_log' TO N'L:\Databases\BOINFSQC9\NBL\dbSafyrSF_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO

ALTER DATABASE [dbSafyrSF] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbSafyrSF] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbSafyrSF] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbSafyrSF.bak' WITH  FILE = 1,
  --MOVE N'dbSafyrSF' TO N'L:\Databases\BOINFSQC9\NBL\dbSafyrSF.mdf',  
  --MOVE N'dbSafyrSF_log' TO N'L:\Databases\BOINFSQC9\NBL\dbSafyrSF_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO

ALTER DATABASE [dbMercamSoft] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbMercamSoft] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbMercamSoft] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbMercamSoft.bak' WITH  FILE = 1,
--  MOVE N'dbAlianza_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Data.mdf',
--  MOVE N'dbAlianza_Indices' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_Idx.ndf',
-- MOVE N'dbAlianza_log' TO N'L:\Databases\BOINFSQC9\NBL\dbAlianza_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO

ALTER DATABASE [dbValoracion] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbValoracion] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbValoracion] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbValoracion.bak' WITH  FILE = 1,
--  MOVE N'dbValoracion_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbValoracion.mdf',
--  MOVE N'dbValoracion2_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbValoracion2.ndf',
--  MOVE N'dbValoracion_Log' TO N'L:\Databases\BOINFSQC9\NBL\dbValoracion_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO

ALTER DATABASE [dbSatelite] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbSatelite] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbSatelite] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbSatelite.bak' WITH  FILE = 1,
--  MOVE N'dbValoracion_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbValoracion.mdf',
--  MOVE N'dbValoracion2_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbValoracion2.ndf',
--  MOVE N'dbValoracion_Log' TO N'L:\Databases\BOINFSQC9\NBL\dbValoracion_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO

ALTER DATABASE [dbUtilidadesHCB] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [dbUtilidadesHCB] SET  MULTI_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dbUtilidadesHCB] FROM  DISK = N'\\boinfsql6\backup\boinfsql6_dbUtilidadesHCB.bak' WITH  FILE = 1,
--  MOVE N'dbValoracion_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbValoracion.mdf',
--  MOVE N'dbValoracion2_Data' TO N'L:\Databases\BOINFSQC9\NBL\dbValoracion2.ndf',
--  MOVE N'dbValoracion_Log' TO N'L:\Databases\BOINFSQC9\NBL\dbValoracion_log.ldf',
    NOUNLOAD,  REPLACE,  STATS = 10
GO




-- PERMISOS BOINFSQC6\QA10


---------------------------------------------------------------------------------------------------	
USE dbA2Utils	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_AlianzaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\CS_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbA2UtilsCival
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_AlianzaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\CS_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	


---------------------------------------------------------------------------------------------------	
USE dbA2UtilsEncuenta	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [A2Utilidades] , @membername = [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_datareader] , @membername = [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CE165965] , @name_in_db =  [HFSG\CE165965]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CE165965]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_ALIANZACAT]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_ALIANZACAT]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\Cs_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\Cs_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_backupoperator] , @membername = [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbAlianza	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_ALIANZACAT]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_ALIANZACAT]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\Cs_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\Cs_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbAlianzaUtilidades_v10	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_ALIANZACAT]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_ALIANZACAT]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\Cs_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\Cs_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbAPTs	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_AlianzaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\CS_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbEncuenta	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CE165965] , @name_in_db =  [HFSG\CE165965]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CE165965]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_ALIANZACAT]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_ALIANZACAT]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\Cs_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\Cs_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbMercamsoft	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CE165965] , @name_in_db =  [HFSG\CE165965]	
    exec sp_addrolemember @rolename = [db_datareader] , @membername = [HFSG\CE165965]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_AlianzaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\CS_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbOyD	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [ejecucion_encuenta] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CE165965] , @name_in_db =  [HFSG\CE165965]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CE165965]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_ALIANZACAT]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_ALIANZACAT]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\Cs_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\Cs_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbOyD_Cival
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [ejecucion_encuenta] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CE165965] , @name_in_db =  [HFSG\CE165965]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CE165965]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_ALIANZACAT]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_ALIANZACAT]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\Cs_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\Cs_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	

---------------------------------------------------------------------------------------------------	
USE dbSafyr	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [CS_ODI] , @name_in_db =  [CS_ODI]	
    exec sp_addrolemember @rolename = [db_odi] , @membername = [CS_ODI]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_AlianzaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\CS_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbSafyrFormatos	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_AlianzaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\CS_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbSafyrSF	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_AlianzaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\CS_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbSatelite	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CE165965] , @name_in_db =  [HFSG\CE165965]	
    exec sp_addrolemember @rolename = [db_datareader] , @membername = [HFSG\CE165965]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_AlianzaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\CS_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbUtilidadesHCB	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_AlianzaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\CS_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
GO	
---------------------------------------------------------------------------------------------------	
USE dbValoracion	
---------------------------------------------------------------------------------------------------	
  exec sp_grantdbaccess @loginame = [Cs_EncuentaCat] , @name_in_db =  [Cs_EncuentaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [Cs_EncuentaCat]	
  exec sp_grantdbaccess @loginame = [sa] , @name_in_db =  [dbo]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [dbo]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_ALIANZACAT] , @name_in_db =  [HFSG\CS_AlianzaCat]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaCat]	
  exec sp_grantdbaccess @loginame = [HFSG\CS_AlianzaInt] , @name_in_db =  [HFSG\CS_AlianzaInt]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\CS_AlianzaInt]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [db_owner] , @membername = [HFSG\GR80452]	
  exec sp_grantdbaccess @loginame = [HFSG\GR80452] , @name_in_db =  [HFSG\GR80452]	
    exec sp_addrolemember @rolename = [public] , @membername = [HFSG\GR80452]	
GO	

USE MASTER
GO

