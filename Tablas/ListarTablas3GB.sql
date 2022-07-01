--Listar tablas de mas de 3 GB HTV

--valida exitencia de tablas tablas temporales

Declare @TableSizes
table 
(
            TableName NVARCHAR(255),
            TableRows INT,
            ReservedSpaceKB VARCHAR(20),
            DataSpaceKB VARCHAR(20),
            IndexSizeKB VARCHAR(20),
		    UnusedSpaceKB VARCHAR(20)
)
--listado de Tablas Grandes de la BD

INSERT INTO @TableSizes
EXEC sp_msforeachtable 'sp_spaceused ''?'''

SELECT  CONVERT(sysname, SERVERPROPERTY('servername')) as Instancia, DB_NAME ()   as BaseDatos, 
TableName, 
cast (replace (DataSpaceKB, 'KB' , '' )as int )/
1024 + cast (replace (IndexSizeKB, 'KB' , '' )as int )/1024 as "Tamaño Tabla"
FROM @TableSizes
--where cast (replace (DataSpaceKB, 'KB' , '' )as int )/1024 >= 3120-- mayores a 3 GB
ORDER BY  cast (replace (DataSpaceKB, 'KB' , '' )as int )desc
go