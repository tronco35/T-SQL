
IF  EXISTS (
select * from tempdb.sys.tables
where name like '#move%')
drop table #move
go

declare @ruta nvarchar (max) = 'C:\a\'-- ruta backup
declare @BD nvarchar (50) = 'SSISDB' --base a restaurar 
declare @rd nvarchar (max) = 'C:\a\' --destino datafiles
declare @rdL nvarchar (max) = 'C:\b\' --destino log
declare @path nvarchar (max) =  @ruta + @BD + '.bak'


DECLARE @fileListTable TABLE (
    [LogicalName]           NVARCHAR(128),
    [PhysicalName]          NVARCHAR(260),
    [Type]                  CHAR(1),
    [FileGroupName]         NVARCHAR(128),
    [Size]                  NUMERIC(20,0),
    [MaxSize]               NUMERIC(20,0),
    [FileID]                BIGINT,
    [CreateLSN]             NUMERIC(25,0),
    [DropLSN]               NUMERIC(25,0),
    [UniqueID]              UNIQUEIDENTIFIER,
    [ReadOnlyLSN]           NUMERIC(25,0),
    [ReadWriteLSN]          NUMERIC(25,0),
    [BackupSizeInBytes]     BIGINT,
    [SourceBlockSize]       INT,
    [FileGroupID]           INT,
    [LogGroupGUID]          UNIQUEIDENTIFIER,
    [DifferentialBaseLSN]   NUMERIC(25,0),
    [DifferentialBaseGUID]  UNIQUEIDENTIFIER,
    [IsReadOnly]            BIT,
    [IsPresent]             BIT,
    [TDEThumbprint]         VARBINARY(32) -- remove this column if using SQL 2005
	,SnapshotUrl nvarchar (max)--nuevo
)
INSERT INTO @fileListTable EXEC('restore FILELISTONLY  FROM DISK = ''' + @path + '''')
--SELECT * FROM @fileListTable


DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While
declare @lName nvarchar (50)
declare @pn nvarchar (max)

create table #move(
id int identity (1,1),
consulta nvarchar (100))
insert into #move 
select 'RESTORE DATABASE ' +   @BD  +  ' FROM  DISK = ' +''''+ @path +'''' + ' WITH ' 


SELECT @max = (select count (LogicalName) from  @fileListTable where [Type] = 'D')
SELECT @min = 1
WHILE @min <= @max
BEGIN
select @lName = LogicalName, @pn = [PhysicalName]    from  @fileListTable where [FileID] = @min and  [Type] = 'D'

insert into #move
select  ' move ''' + @lName + ''' TO '''+ @rd  +RIGHT(@pn  , CHARINDEX ('\' ,REVERSE(@pn))-1) +'''' + ','

SET @min = @min + 1
end

declare @pn1 nvarchar (max)
select @lName = LogicalName, @pn1 = [PhysicalName]    from  @fileListTable where  [Type] = 'L'
insert into #move (consulta)
select  ' move ''' + @lName + ''' TO '''+ @rdL  +RIGHT(@pn1  , CHARINDEX ('\' ,REVERSE(@pn1))-1) +'''' + ',  NOUNLOAD,  STATS = 5, replace'

select * from #move
--drop table #move
--print 'RESTORE DATABASE '+ @BD 
