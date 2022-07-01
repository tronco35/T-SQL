use navdb

create table #db(id int identity (1,1), 
name nvarchar (50) )

insert into #db (name)

select name  from sys.tables


DECLARE @max INT --Valor Maximo del While
DECLARE @name NVARCHAR(50) -- Nombre de la tabla
DECLARE @min INT --Valor Minimo del While 
declare @sentencia nvarchar (50)


SELECT @max = (SELECT count(name)  from sys.tables)


SELECT @min = 1
WHILE @min <= @max

	BEGIN

select @name = name from #db
where  ID = @min

begin

set @sentencia = 'Drop table ' + @name

exec (@sentencia)
end

SET @min = @min + 1


--drop table #db
END

