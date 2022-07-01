select * from msdb.dbo.sysdtspackages

where name like '%balance%'

 IF OBJECT_ID ('[tempdb]..[#JOBS&SSIS]' , 'U' ) IS NOT NULL
 DROP TABLE [#JOBS&SSIS] 
 GO

CREATE TABLE [#JOBS&SSIS](
       [name] [sysname] NOT NULL,
       [dts] [varchar](50) NULL)
       GO

 declare @nombre varchar (50)
 Declare @comn varchar (100)
 set @comn = '%'
 Declare crs_ssis cursor for
  
 SELECT distinct ([name])
 FROM msdb.dbo.sysdtspackages

 open crs_ssis
 FETCH NEXT
 from  crs_ssis
 into @nombre
 while @@FETCH_STATUS = 0
 begin
 insert into [#JOBS&SSIS]
  ([name],[dts])
 select j.name, @nombre as dts
 from msdb.dbo.sysjobs as j inner join msdb.dbo.sysjobsteps as s ON j.job_id = s.job_id
 where command like @comn + @nombre + @comn
 FETCH NEXT
 from  crs_ssis
 into @nombre
 end
 close crs_ssis
 DEALLOCATE crs_ssis

 select Name, dts
 from [#JOBS&SSIS]