SELECT
  ctg.[Path]
, s.[Description] SubScriptionDesc
, sj.[description] AgentJobDesc
, s.LastStatus
, s.DeliveryExtension
, s.[Parameters]
FROM
  ReportServer.dbo.[Catalog] ctg 
    INNER JOIN 
  ReportServer.dbo.Subscriptions s on s.Report_OID = ctg.ItemID
    INNER JOIN
  ReportServer.dbo.ReportSchedule rs on rs.SubscriptionID = s.SubscriptionID
    INNER JOIN
  msdb.dbo.sysjobs sj ON CAST(rs.ScheduleID AS sysname) = sj.name
ORDER BY
  rs.ScheduleID;