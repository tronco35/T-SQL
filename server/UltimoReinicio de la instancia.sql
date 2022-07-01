


IF OBJECT_ID('tempdb..#logtotal') IS NOT NULL
drop table #logtotal

create table #logtotal

(logDate datetime  ,
ProcessInfo nvarchar (12),
text nvarchar (max)
)


insert into #logtotal
EXEC xp_ReadErrorLog 6, 1

insert into #logtotal
EXEC xp_ReadErrorLog 5, 1


insert into #logtotal
EXEC xp_ReadErrorLog 4, 1

insert into #logtotal
EXEC xp_ReadErrorLog 3, 1 

insert into #logtotal
EXEC xp_ReadErrorLog 2, 1

insert into #logtotal
EXEC xp_ReadErrorLog 1, 1 


insert into #logtotal
EXEC xp_ReadErrorLog 0, 1


select logdate, ProcessInfo, text from #logtotal 
where text like 'SQL server is starting%' or text  like 'The error log has been reinitialized'
order by logdate desc



