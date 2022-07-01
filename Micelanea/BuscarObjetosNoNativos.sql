
create table #db (D_creacion datetime, BD  nvarchar (50) )

insert into #db (d_creacion, BD)

select cast (create_date as date) as D_creacion, name as BD from sys.databases
where name not in ('master','msdb','model','tempdb')


select cast (o.create_date as date), s.name as Esquema, o.name, type_desc 
from sys.objects as o
inner join sys.schemas as s on o.schema_id = s.schema_id
--inner join #db as d ON cast (o.create_date as date) = D_creacion
where type in ('U','FN','IF','P', 'SN', 'V') 


--select * from sys.schemas



--select * from #db

--drop table #db

