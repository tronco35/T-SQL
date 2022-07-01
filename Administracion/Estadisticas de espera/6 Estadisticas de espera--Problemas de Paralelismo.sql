--Reducir CXPACKET wait

--tipo OLTP

EXEC sys.sp_configure N'max degree of parallelism', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO

--Data-warehousing / Reporting server OLAP: 
EXEC sys.sp_configure N'max degree of parallelism', N'0'
GO
RECONFIGURE WITH OVERRIDE
GO

--Mixto (OLTP & OLAP):

EXEC sys.sp_configure N'cost threshold for parallelism', N'25'
GO
EXEC sys.sp_configure N'max degree of parallelism', N'2'
GO
RECONFIGURE WITH OVERRIDE
GO