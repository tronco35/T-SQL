
/***************************************************************
Backup varios BD
(c) 20161011 Henry Troncoso Valencia
HelmBank
*****************************************************************/

BEGIN
create table #db(id int identity (1,1), 
name nvarchar (50) )


insert into #db (name)
select name  from sys.databases
where name  in ('AxonV37Negocio', 'AxonV37Usuario') 

DECLARE @max INT --Valor Maximo del While
Declare @path nvarchar (50) 
set @path = '\\boinfsqc5\backupF\' --ruta
DECLARE @fileDate NVARCHAR(20) -- Fecha
SELECT @fileDate = CONVERT(nvarchar(20),GETDATE(),112) 
DECLARE @fileName NVARCHAR(256) -- nombre del archivo del Backup
DECLARE @name NVARCHAR(50) -- Nombre de la base de datos 
DECLARE @min INT --Valor Minimo del While 


SELECT @max = (SELECT count(database_id) from sys.databases where 
name  in ('AxonV37Negocio', 'AxonV37Usuario'))

SELECT @min = 1
WHILE @min <= @max

	BEGIN

select @name = name from #db
where  ID = @min

begin
SET @fileName = @path + @name + '_' + @fileDate + '.BAK' 
BACKUP DATABASE @name  TO  DISK = @fileName   WITH COPY_ONLY, NOFORMAT, NOINIT,   SKIP, NOREWIND, NOUNLOAD, 
COMPRESSION,  STATS = 10		
			
end

SET @min = @min + 1
end

drop table #db
END

