use master
go

--cretate DMK en master 
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Bogota123456*';

--create certificate en master
CREATE CERTIFICATE Security_Certificate2
WITH SUBJECT = 'DEK_Certificate';

--ejecutar en base de usuario 
CREATE DATABASE ENCRYPTION KEY WITH ALGORITHM = AES_256--AES_256 --TRIPLE_DES_3KEY
ENCRYPTION BY SERVER CERTIFICATE Security_Certificate2;

ALTER DATABASE internetSales SET ENCRYPTION ON;

