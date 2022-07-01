--VLF
--https://blogs.msdn.microsoft.com/canberrapfe/2015/01/07/sql-server-2014-updated-vlf-creation-algorithm/
--algoritmo Kimberly L. Tripp
--chunks less than 64MB and up to 64MB = 4 VLFs
--chunks larger than 64MB and up to 1GB = 8 VLFs
--chunks larger than 1GB = 16 VLFs
--4 VLFS + (249 x 4 VLFs) = 1000 VLFs
--10MB + (249 x 10MB) = 2500MB

--What is the new algorithm in SQL Server 2014?

--If
--         growth < current size / 8 = 1 VLF
--else
--         growth <= 64MB = 4 VLFs
--         growth > 64MB AND <= 1024MB = 8 VLFs
--         growth > 1024MB = 16 VLFS

dbcc loginfo
--Columna	Descripción
--RecoveryUnitID	
--FileID	Este es el número de identificación del archivo físico del registro. Sólo aplica si usted tiene más de un archivo de registro físico.
--FileSize	El tamaño del archivo en bytes
--StartOffset	Este es el offset desde donde el VLF comienza en bytes. La salida es ordenada en esta columna.
--FSeqNo	Este es el orden en el que el VLF será usado. El número más grande es el cual está siendo actualmente usado.
--Status	Hay 2 posibles valores, 0 y 2. 2 significa que el VLF no puede ser reutilizado y 0 significa que está listo para reutilizarse.
--Parity	Hay 2 posibles valores, 64 y 128.
--CreateLSN	Este es el LSN cuando el VLF fue creado. Si createLSN es 0, significa que fue creado cuando se creó el archivo físico del registro de transacciones.


--espacio utilizado
DBCC SQLPERF(LOGSPACE);
GO

--modificar log
--ALTER DATABASE DbSarc MODIFY FILE (NAME =N'DBSARC_Log',SIZE=60MB)