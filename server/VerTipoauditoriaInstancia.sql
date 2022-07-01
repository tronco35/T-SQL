DECLARE @LoginAuditing int
EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', 
N'Software\Microsoft\MSSQLServer\MSSQLServer',   
N'AuditLevel', @LoginAuditing   OUTPUT  

SELECT CASE  @LoginAuditing   
WHEN 0 THEN 'Ninguno'
WHEN 2 THEN 'Solamente Accesos Fallidos'   
WHEN 1 THEN 'Solo los Acessos Exitosos'   
WHEN 3 THEN 'Accesos exitosos y Fallidos'    
END as "Tipo de Auditoría"
