create table #db(id int identity (1,1), 
name nvarchar (50) )

insert into #db (name)
select name  from sys.databases
where name  not in ( 'master' ,'model', 'msdb', 'tempdb', 'diagnosticoSQL') 

DECLARE @max INT --Valor Maximo del While
Declare @path nvarchar (50) 
set @path = 'G:\WIN-0VULQGK4G3Q\' --ruta
DECLARE @fileDate NVARCHAR(20) -- Fecha
SELECT @fileDate = DATEPART (HOUR, getdate())

DECLARE @name NVARCHAR(50) -- Nombre de la base de datos 
DECLARE @min INT --Valor Minimo del While 
,@ext NVARCHAR(50)  = '_Full.BAK' 
,@fileName1 NVARCHAR(256) -- nombre del archivo del Backup
,@fileName2 NVARCHAR(256)
,@fileName3 NVARCHAR(256)
,@fileName4 NVARCHAR(256)

SELECT @max = (SELECT count(database_id) from sys.databases  
where name  not in ( 'master' ,'model', 'msdb', 'tempdb','diagnosticoSQL') )

SELECT @min = 1
WHILE @min <= @max

	BEGIN

select @name = name from #db
where  ID = @min

begin
SET @fileName1 = @path + @name + '_' + @fileDate ++ '_OnePart'+ '_Diff.BAK'
set @fileName2 = @path + @name + '_' + @fileDate + +'_TwoPart'+ '_Diff.BAK'
set @fileName3 = @path + @name + '_' + @fileDate + +'_ThreePart'+ '_Diff.BAK'
set @fileName4 = @path + @name + '_' + @fileDate + +'_FourPart'+ '_Diff.BAK'
BACKUP DATABASE @name  TO  DISK = @fileName1 , DISK = @fileName2, DISK = @fileName3, DISK = @fileName4  
WITH DIFFERENTIAL, NOFORMAT, INIT,   SKIP, NOREWIND, NOUNLOAD, 
COMPRESSION,  STATS = 10				
end

SET @min = @min + 1
end

drop table #db
