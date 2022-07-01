
select  t.name as Tabla, i.name as Indice, f.fileid, f.name, g.groupname
from sysindexes i inner join sysfiles f on i.groupid = f.groupid 
inner join sysfilegroups g on f.groupid = g.groupid inner join sys.tables as t
On i.id = t.object_id
