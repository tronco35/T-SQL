IF OBJECT_ID (N'dbo.UFN_Auditoria', N'TF') IS NOT NULL  
    DROP FUNCTION dbo.UFN_Auditoria;  
GO  

CREATE FUNCTION dbo.UFN_Auditoria ()  
RETURNS
 @informe  table
(
id as cnt + cnt_time ,
cnt int identity (1,1),
cnt_time int,
corrected_time	nvarchar (max),
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
audit_file_offset	nvarchar (max)

--Solo para sql 2012 en adelante--
--,user_defined_event_id	nvarchar (max),
--user_defined_information nvarchar (max)

)
as
begin
DECLARE @max INT --Valor Maximo del While
DECLARE @min INT --Valor Minimo del While 
DECLARE @audit_file_path NVARCHAR(255) -- Nombre de la auditoria
declare @insumo varchar (max)


SELECT @max = count (name) FROM sys.server_file_audits
SELECT @min = 1
WHILE @min <= @max


	BEGIN

	with cteSAE
as
(
SELECT rank () over (order by name) as id,name, audit_file_path FROM sys.dm_server_audit_status
)

select @audit_file_path = audit_file_path from cteSAE
where  ID = @min


begin

insert into @informe (cnt_time,
corrected_time,	sequence_number,	action_id,	succeeded,	permission_bitmask,	is_column_permission,	session_id,	
server_principal_id,	database_principal_id,	target_server_principal_id,	target_database_principal_id,	object_id,
class_type,	session_server_principal_name,	server_principal_name,	server_principal_sid,	database_principal_name,
target_server_principal_name,	target_server_principal_sid,	target_database_principal_name, server_instance_name,
database_name,	schema_name,	object_name,	statement,	additional_information,	file_name,	audit_file_offset
--user_defined_event_id,	user_defined_information --Solo para sql 2012 en adelante--
)

select 
cast (cast (event_time as datetime ) as int ) * 1000 c_time,
DATEADD(hh, DATEDIFF(hh, GETUTCDATE(), CURRENT_TIMESTAMP), event_time ) as corrected_time,	sequence_number,	
action_id,	succeeded,	permission_bitmask,	is_column_permission,	session_id,	
server_principal_id,	database_principal_id,	target_server_principal_id,	target_database_principal_id,	object_id,
class_type,	session_server_principal_name,	server_principal_name,	server_principal_sid,	database_principal_name,
target_server_principal_name,	target_server_principal_sid,	target_database_principal_name, server_instance_name,
database_name,	schema_name,	object_name,	statement,	additional_information,	file_name,	audit_file_offset
--,user_defined_event_id,	user_defined_information --Solo para sql 2012 en adelante--
FROM sys.fn_get_audit_file 
( @audit_file_path , default, default) 
WHERE DATEADD(hh, DATEDIFF(hh, GETUTCDATE(), CURRENT_TIMESTAMP), event_time ) > cast( getdate ()as date)
order by event_time

end 

SET @min = @min + 1
end
return
end

go


----llamar la funcion
--select id, corrected_time,	sequence_number,	action_id,	succeeded,	permission_bitmask,	is_column_permission,session_id,	
--server_principal_id, database_principal_id,	target_server_principal_id,	target_database_principal_id,	object_id,class_type,	
--session_server_principal_name,	server_principal_name,	server_principal_sid,	database_principal_name,
--target_server_principal_name,	target_server_principal_sid,	target_database_principal_name, server_instance_name,
--database_name,	schema_name,	object_name,	statement,	additional_information,	file_name,	audit_file_offset 
--from dbo.UFN_Auditoria ()
--go




