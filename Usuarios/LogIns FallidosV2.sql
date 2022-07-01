/********************************
login Fallidos
(c) 2061012 Henry Troncoso 

*******************************/
 
declare @table as table 
(fecha datetime, 
Tipo_proceso nvarchar (20),
texto  nvarchar (max) )
declare @rango as table
(fecha datetime --nvarchar (200)
, texto  nvarchar (max) 
, rango int
)

insert @table 
EXEC sys.xp_readerrorlog 0, 1, 'Login failed'
--antes
insert @table 
EXEC sys.xp_readerrorlog 2, 1, 'Login failed'
insert @rango
select fecha , texto , rank () over (partition by Texto order by fecha desc ) as rango from @table

select CONVERT(sysname, SERVERPROPERTY('servername')) as Instancia ,Fecha, texto 
from @rango where rango = 1 and fecha > cast (getdate () -2 as date) -- Dias que quiero como maximo devolver el log
order by fecha desc

--por fecha 
--select fecha, Texto from @table
--order by fecha desc
