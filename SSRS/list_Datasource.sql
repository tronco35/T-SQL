-- List connection strings of all SSRS Shared Datasources 
;WITH XMLNAMESPACES  -- XML namespace def must be the first in with clause. 
    (DEFAULT 'http://schemas.microsoft.com/sqlserver/reporting/2006/03/reportdatasource' 
            ,'http://schemas.microsoft.com/SQLServer/reporting/reportdesigner' 
     AS rd) 
,SDS AS 
    (SELECT SDS.name AS SharedDsName 
           ,SDS.[Path] 
           ,CONVERT(xml, CONVERT(varbinary(max), content)) AS DEF 
     FROM dbo.[Catalog] AS SDS 
     WHERE SDS.Type = 5)     -- 5 = Shared Datasource 
 
SELECT CON.[Path] 
      ,CON.SharedDsName 
      ,CON.ConnString 
FROM 
    (SELECT SDS.[Path] 
           ,SDS.SharedDsName 
           ,DSN.value('ConnectString[1]', 'varchar(150)') AS ConnString 
     FROM SDS 
          CROSS APPLY  
          SDS.DEF.nodes('/DataSourceDefinition') AS R(DSN) 
     ) AS CON 
-- Optional filter: 
-- WHERE CON.ConnString LIKE '%Initial Catalog%=%TFS%' 
ORDER BY CON.[Path] 
        ,CON.SharedDsName;