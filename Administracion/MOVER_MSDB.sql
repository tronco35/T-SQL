--MOVER MSDB


ALTER DATABASE msdb MODIFY FILE --base de datos
 ( NAME = MSDBData, FILENAME --nombre l�gico
 = 'M:\Databases\BOINFSQC9\DATA\MSDBData.mdf' )  --ubicaci�n l�gica

 
 ALTER DATABASE msdb MODIFY FILE --base de datos
 ( NAME = MSDBLog , FILENAME  --nombre l�gico
 = 'M:\Databases\BOINFSQC9\LOG\MSDBLog.ldf' )  --ubicaci�n l�gica

 --VALIDAR LA UBICACION DEL ARCHIVO

 
SELECT name, physical_name AS CurrentLocation, state_desc 
FROM sys.master_files 
WHERE database_id = DB_ID(N'MSDB')


SELECT is_broker_enabled 
FROM sys.databases
WHERE name = N'msdb';