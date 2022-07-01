SELECT 	event_time, object_id, server_principal_name, 
	database_name, schema_name, object_name, statement 
FROM
sys.fn_get_audit_file('C:\a\\*', default, default);
