/***********************************
VERIFICAR ROLES A USUARIOS EN UNA BD
************************************/

with cterol
as
(
select d.name,  member_principal_id from sys.database_role_members as r
inner join sys.database_principals as d ON d.principal_id = role_principal_id
)

select db_name () as "Base de datos", l.name as Usuario, c.name as ROL_BD from sys.syslogins as l  inner join 
sys.database_principals as d ON l.name COLLATE DATABASE_DEFAULT = d.name COLLATE DATABASE_DEFAULT inner join  cterol as c ON d.principal_id  = c.member_principal_id 
where l.name like '%%' --usuario