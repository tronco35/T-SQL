SELECT
  [ItemPath] --Path of the report
, [UserName]  --Username that executed the report
, [RequestType] --Usually Interactive (user on the scree) or Subscription
, [Format] --RPL is the screen, could also indicate Excel, PDF, etc
, [TimeStart]--Start time of report request
, [TimeEnd] --Completion time of report request
, [TimeDataRetrieval] --Time spent running queries to obtain results
, [TimeProcessing] --Time spent preparing data in SSRS. Usually sorting and grouping.
, [TimeRendering] --Time rendering to screen
, [Source] --Live = query, Session = refreshed without rerunning the query, Cache = report snapshot
, [Status] --Self explanatory
, [RowCount] --Row count returned by a query
, [Parameters]
FROM ReportServer.dbo.ExecutionLog3