



IF OBJECT_ID('tempdb..#audit') IS NOT NULL
drop table #audit

create table #audit(id int identity (1,1) primary key, 
name nvarchar (50) ,
audit_file_path nvarchar (255)
)

IF OBJECT_ID('tempdb..#informe') IS NOT NULL
drop table #informe

create table #informe(id int identity (1,1) primary key, 
event_time	nvarchar (max),
sequence_number	nvarchar (max),
action_id	nvarchar (max),
succeeded	nvarchar (max),
permission_bitmask	nvarchar (max),
is_column_permission	nvarchar (max),
session_id	nvarchar (max),
server_principal_id	nvarchar (max),
database_principal_id	nvarchar (max),
target_server_principal_id	nvarchar (max),
target_database_principal_id nvarchar (max),	
object_id	nvarchar (max),
class_type	nvarchar (max),
session_server_principal_name	nvarchar (max),
server_principal_name	nvarchar (max),
server_principal_sid	nvarchar (max),
database_principal_name	nvarchar (max),
target_server_principal_name	nvarchar (max),
target_server_principal_sid	nvarchar (max),
target_database_principal_name	nvarchar (max),
server_instance_name	nvarchar (max),
database_name	nvarchar (max),
schema_name	nvarchar (max),
object_name	nvarchar (max),
statement	nvarchar (max),
additional_information	nvarchar (max),
file_name nvarchar (max),	
audit_file_offset	nvarchar (max),
user_defined_event_id	nvarchar (max),
user_defined_information nvarchar (max)

)

insert into #audit (
name,
audit_file_path
)
SELECT name, audit_file_path FROM sys.dm_server_audit_status



DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While 
DECLARE @audit_file_path NVARCHAR(255) -- Nombre de la auditoria
declare @insumo varchar (max)


SELECT @max = count (name) FROM sys.server_file_audits

SELECT @min = 1
WHILE @min <= @max


	BEGIN



select @audit_file_path = audit_file_path from #audit
where  ID = @min


begin

insert into #informe (
event_time,	sequence_number,	action_id,	succeeded,	permission_bitmask,	is_column_permission,	session_id,	
server_principal_id,	database_principal_id,	target_server_principal_id,	target_database_principal_id,	object_id,
class_type,	session_server_principal_name,	server_principal_name,	server_principal_sid,	database_principal_name,
target_server_principal_name,	target_server_principal_sid,	target_database_principal_name, server_instance_name,
database_name,	schema_name,	object_name,	statement,	additional_information,	file_name,	audit_file_offset
--user_defined_event_id,	user_defined_information

)

select 
event_time,	sequence_number,	action_id,	succeeded,	permission_bitmask,	is_column_permission,	session_id,	
server_principal_id,	database_principal_id,	target_server_principal_id,	target_database_principal_id,	object_id,
class_type,	session_server_principal_name,	server_principal_name,	server_principal_sid,	database_principal_name,
target_server_principal_name,	target_server_principal_sid,	target_database_principal_name, server_instance_name,
database_name,	schema_name,	object_name,	statement,	additional_information,	file_name,	audit_file_offset
--,user_defined_event_id,	user_defined_information
FROM sys.fn_get_audit_file 
( @audit_file_path , default, default) 
--WHERE DATEADD(hh, DATEDIFF(hh, GETUTCDATE(), CURRENT_TIMESTAMP), event_time ) > CONVERT(VARCHAR(8), DATEADD(DAY, -1, GETDATE()), 
--112) and  DATEADD(hh, DATEDIFF(hh, GETUTCDATE(), CURRENT_TIMESTAMP), event_time ) < CONVERT(VARCHAR(8), GETDATE(), 112)



end

SET @min = @min + 1
end
go

select * from #informe
order by event_time desc
go



