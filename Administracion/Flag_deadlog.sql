/* Enable Trace Flags 1204 and 1222 at global level */

DBCC TRACEON (1204,-1)
GO
DBCC TRACEON (1222,-1)
GO

/* Second Option Enabling Trace Flags 1204 and 1222 using DBCC TRACEON Statement at global level */

DBCC TRACEON (1204, 1222, -1)
GO

Read more: http://www.mytechmantra.com/LearnSQLServer/Identify-Deadlocks-in-SQL-Server-Using-Trace-Flag-1222-and-1204/#ixzz4SAkp7hfj 
Follow us: @MyTechMantra on Twitter | MyTechMantra on Facebook