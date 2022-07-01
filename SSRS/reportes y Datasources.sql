SELECT
  [Path]
, CASE [Type]
    WHEN 2 THEN 'Report'
    WHEN 5 THEN 'Data Source'    
  END AS TypeName
, CAST(CAST(content AS varbinary(max)) AS xml)
, [Description]
FROM ReportServer.dbo.[Catalog] CTG
WHERE
  [Type] IN (2, 5);