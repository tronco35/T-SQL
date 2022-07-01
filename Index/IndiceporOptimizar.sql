select object_name(object_id) AS Tabla
,equality_columns, inequality_columns, included_columns, statement,user_seeks, user_scans
, avg_total_user_cost, avg_user_impact
from sys.dm_db_missing_index_details id
join sys.dm_db_missing_index_groups ig on id.index_handle = ig.index_handle
join sys.dm_db_missing_index_group_stats igs on ig.index_group_handle = igs.group_handle
where database_id = db_id()
order by user_seeks desc