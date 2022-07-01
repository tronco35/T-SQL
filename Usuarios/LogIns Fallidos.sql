/********************************
login Fallidos
(c) 2061012 Henry Troncoso 

*******************************/
 
declare @table as table 
(fecha datetime, 
Tipo_proceso nvarchar (20),
texto  nvarchar (max) )
--hoy
insert @table 
EXEC sys.xp_readerrorlog 0, 1, 'Login failed'
--ayer
insert @table 
EXEC sys.xp_readerrorlog 2, 1, 'Login failed'


--usuarios
select distinct Texto  from @table

--por fecha 
--select fecha, Texto from @table
--order by fecha desc
