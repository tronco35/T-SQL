/* 
restore de varios de confirming
deben estar en la misma ubicacion de origen*/
--drop table #dbrestore
declare @path nvarchar (60)
declare @dia nvarchar (2)
declare @mes nvarchar (2)
declare @ano nvarchar (4)
declare @fecha nvarchar (50)
declare @bd1 nvarchar (20)
declare @bd2 nvarchar (20)
declare @bd3 nvarchar (20)
declare @bd4 nvarchar (20)
declare @bd5 nvarchar (20)
declare @bd6 nvarchar (20)
declare @bd7 nvarchar (20)
declare @bd8 nvarchar (20)
declare @bd9 nvarchar (20)

set @ano = DATEPART (YEAR, getdate ())
set @mes = right ( cast (getdate ()as date) , 5)
set @dia = right ( cast (getdate ()as date) , 2)
set @path = '\\boinfsqc5\backupF\' 
set @fecha = '_' + @ano + @mes + @dia + '.bak'
set @bd1 = 'CORP_CONFIRMING'
set @bd2 = 'CORP_CONTAB'
set @bd3 = 'CORP_FACTOR'
set @bd4 = 'CORP_INTERFASES'
set @bd5 = 'CORP_LINEA_GLOBAL'
set @bd6 = 'CORP_MIGRACION'
set @bd7 = 'CORP_SEGURIDAD'
set @bd8 = 'CORP_TASAS'
set @bd9 = 'CORP_TRASCON'

create table #dbrestore(id int identity (1,1) primary key clustered, 
path_bk nvarchar (100) ,
bd nvarchar (20)
) 
--BD que voy a restaurar 
insert into #dbrestore (path_bk, bd)
values
 (@path + @bd1 +  @fecha, @bd1)
,(@path + @bd2 + @fecha, @bd2)
,(@path + @bd3 +  @fecha, @bd3)
,(@path + @bd4 + @fecha, @bd4)
,(@path + @bd5  + @fecha, @bd5)
,(@path + @bd6  + @fecha, @bd6)
,(@path + @bd7  + @fecha, @bd7)
,(@path + @bd8  + @fecha, @bd8)
,(@path + @bd9  + @fecha, @bd9 )

DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @name NVARCHAR(50) -- bd
declare @ruta nvarchar (50)  -- ruta

SELECT @max = (select count (path_bk) from #dbrestore)
SELECT @min = 1
WHILE @min <= @max

BEGIN

select @name = bd , @ruta = path_bk from #dbrestore
where  ID = @min

 begin 
restore database @name FROM DISK = @ruta

WITH REPLACE, FILE = 1, NOUNLOAD, RECOVERY, STATS = 10

end

SET @min = @min + 1
end
go







