BACKUP DATABASE [AxonDatos_V37] TO  DISK = N'\\SBCCO1506\Backup\AxonDatos_V37.bak' 
WITH  COPY_ONLY, NOFORMAT, NOINIT,  NAME = N'AxonDatos_V37 Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  
STATS = 10
GO


BACKUP DATABASE [AxonUsuarios_V37] TO  DISK = N'\\SBCCO1506\Backup\AxonUsuarios_V37.bak' 
WITH  COPY_ONLY, NOFORMAT, NOINIT,  NAME = N'AxonUsuarios_V37 Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  
STATS = 10
GO