USE MASTER 
GO

--VALIDAR VERSION 
--restore HEADERONLY  FROM DISK = '\\boinfsqln3\backups\Firmas_20160809.bak'
--VALIDAR NOMBRES LOGICOS
--restore FILELISTONLY  FROM DISK = N'\\boinfsqc5\backupF\AxonV37Negocio_20170213.BAK'


--RESTORE
restore database MigracionNegocio FROM DISK = N'\\boinfsqc5\backupF\AxonV37Negocio_20170213.BAK'
WITH
replace,
MOVE 'PopularNegocio_Data' TO 'O:\Databases\BOINFSQC9_QA10\AxonV37Negocio.mdf',
MOVE 'PopularNegocio_Data01' TO 'O:\Databases\BOINFSQC9_QA10\AxonV37Negocio01.mdf',
--MOVE 'dbOyDPruebas_Data01' TO 'H:\Data\dbOyD_Data01.ndf',
--MOVE 'dbOyDPruebas_Data02' TO 'H:\Data\dbOyD_Data02.ndf',
MOVE 'PopularNegocio_Log' TO 'O:\Databases\BOINFSQC9_QA10\AxonV37Negocio_1.ldf',
FILE = 1, NOUNLOAD, RECOVERY, STATS = 10





restore FILELISTONLY  FROM DISK = N'\\boinfsqc5\backupF\AxonV37Usuario_20170213.BAK'
--RESTORE
restore database MigracionUsuario FROM DISK = N'\\boinfsqc5\backupF\AxonV37Usuario_20170213.BAK'
WITH
replace,
MOVE 'PopularUsuarios_Data' TO 'O:\Databases\BOINFSQC9_QA10\AxonV37Usuario.mdf',
MOVE 'PopularUsuarios_Data01' TO 'O:\Databases\BOINFSQC9_QA10\AxonV37Usuario01.ndf',
--MOVE 'dbOyDPruebas_Data01' TO 'H:\Data\dbOyD_Data01.ndf',
--MOVE 'dbOyDPruebas_Data02' TO 'H:\Data\dbOyD_Data02.ndf',
MOVE 'PopularUsuarios_Log' TO 'O:\Databases\BOINFSQC9_QA10\AxonV37Usuario_1.ldf',
FILE = 1, NOUNLOAD, RECOVERY, STATS = 10


