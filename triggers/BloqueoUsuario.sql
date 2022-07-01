

IF EXISTS (SELECT * FROM sys.triggers WHERE parent_class = 0 AND name = 'TGR_NoSSMS')
DROP TRIGGER TGR_NoSSMS ON ALL SERVER
GO
/************************************************
TGR_NoSSMS
c 2016/08/18 Henry Troncoso 
Bloquea el acceso de SSMS del usuario CS_Aranda8
Solo permite acceder desde el servidor de APP

*************************************************/

CREATE TRIGGER TGR_NoSSMS
ON ALL SERVER WITH EXECUTE AS 'CS_Aranda8'  
FOR LOGON  
AS  
BEGIN  
IF ORIGINAL_LOGIN()= 'CS_Aranda8' AND  
    (SELECT COUNT(*)
FROM sys.dm_exec_sessions
WHERE  [PROGRAM_NAME] = 'Microsoft SQL Server Management Studio' and 
login_name = 'CS_Aranda8' and [host_name] != 'SBCCOARANDAIN')  > 0
    ROLLBACK;  
END;  
  




