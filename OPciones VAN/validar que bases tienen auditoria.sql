/*==================================================
*(c)  12/19/2016 Henry Troncoso
* 
* Ver BD que tienen Auditoria en la instancia
==================================================*/


IF OBJECT_ID('tempdb..##basesaudit') IS NOT NULL
drop table ##basesaudit

create table ##basesaudit
(id int identity (1,1) primary key clustered,
name nvarchar (20),
nombreAuditoria nvarchar (50))

declare @bases as table 
(id int identity (1,1) primary key clustered,
name nvarchar (20))

insert into @bases (name)
select name from sys.databases

DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
DECLARE @name NVARCHAR(50) -- Nombre de la base de datos
DECLARE @command NVARCHAR(max)

SELECT @max =  COUNT (name)  FROM @bases

SELECT @min = 1
WHILE @min <= @max
BEGIN
SET @command = NULL
　

select @name = name from @bases
where  ID = @min

SET @command = 'USE ' + @name + '
insert into ##basesaudit (name,nombreAuditoria )
select DB_NAME () as BasedeDatos, name
from sys.database_audit_specifications where is_state_enabled = 1

'
begin
exec (@command)

end
SET @min = @min + 1

end

GO

select name as BD, nombreAuditoria from ##basesaudit
