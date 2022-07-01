

/**************************************
Usuarios SYSADMIN y los roles asignados
(c) 20160926 Henry Troncoso
**************************************/
use master
go
select SERVERPROPERTY ('ServerName') AS 'NOMBRE_INSTANCIA',
l.name as NombreUsuario, 
p.type_desc as TipoUsuario,
p.is_disabled,
createdate as FechaCreacion,
p.modify_date, denylogin, hasaccess as AccesoServidor,
sysadmin,
securityadmin,
serveradmin,
setupadmin,
processadmin,
diskadmin,
dbcreator,
bulkadmin
 from sys.syslogins as l inner join sys.server_principals as p ON l.sid = p.sid
where sysadmin = 1 and is_disabled = 0
