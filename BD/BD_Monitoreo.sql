--creacion de DWH

CREATE DATABASE [DWHMonitoreo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DWHMonitorieo', FILENAME = N'K:\SQL27_Data03\Databases\DwhMonitoreo\DWHMonitorieo.mdf' , 
SIZE = 4096KB , FILEGROWTH = 0), 
 FILEGROUP [DHW] 
( NAME = N'DHW', FILENAME = N'K:\SQL27_Data03\Databases\DwhMonitoreo\DHW.ndf' , SIZE = 4096KB , FILEGROWTH = 1024KB 
)
 LOG ON 
( NAME = N'DWHMonitorieo_log', FILENAME = N'K:\SQL27_Data03\Databases\DwhMonitoreo\DWHMonitorieo_log.ldf' , SIZE = 
8192000KB , FILEGROWTH = 0)
GO
-- Crecimiento Manual
USE [master]
GO
ALTER DATABASE [DWHMonitoreo] MODIFY FILE ( NAME = N'DHW', FILEGROWTH = 0)
GO

--filegroup por defaul nada en primary
USE [DWHMonitoreo]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'DHW') 
ALTER DATABASE [DWHMonitoreo] MODIFY FILEGROUP [DHW] DEFAULT
GO


/*Creación de la tabla*/
create table DIM_TIEMPO
(
    srk_tiempo int identity ( 1,1) primary key clustered,
	FechaSK int not null,
    Fecha date not null, 
    Año smallint not null,
    Trimestre smallint not null,
    Mes smallint not null,
    Semana smallint not null,
    Dia smallint not null,
    DiaSemana smallint not null,
    NTrimestre char(7) not null,
    NMes char(15) not null,
    NMes3L char(3) not null,
    NSemana char(10) not null,
    NDia char(6) not null,
    NDiaSemana char(10) not null
    
)

/*Script de carga*/
DECLARE @FechaDesde as smalldatetime, @FechaHasta as smalldatetime
DECLARE @FechaAAAAMMDD int
DECLARE @Año as smallint, @Trimestre char(2), @Mes smallint
DECLARE @Semana smallint, @Dia smallint, @DiaSemana smallint
DECLARE @NTrimestre char(7), @NMes char(15)
DECLARE @NMes3l char(3)
DECLARE @NSemana char(10), @NDia char(6), @NDiaSemana char(10)
--Set inicial por si no coincide con los del servidor
SET DATEFORMAT dmy
SET DATEFIRST 1

BEGIN TRANSACTION
    --Borrar datos actuales, si fuese necesario
    --TRUNCATE TABLE FROM DI_TIEMPO
   
    --RAngo de fechas a generar: del 01/01/2006 al 31/12/Año actual+2
    SELECT @FechaDesde = CAST('20160801' AS smalldatetime)
    SELECT @FechaHasta = CAST(CAST(YEAR(GETDATE())+2 AS CHAR(4)) + '1231' AS smalldatetime)
   
    WHILE (@FechaDesde <= @FechaHasta) BEGIN
    SELECT @FechaAAAAMMDD = YEAR(@FechaDesde)*10000+
                            MONTH(@FechaDesde)*100+
                            DATEPART(dd, @FechaDesde)
    SELECT @Año = DATEPART(yy, @FechaDesde)
    SELECT @Trimestre = DATEPART(qq, @FechaDesde)
    SELECT @Mes = DATEPART(m, @FechaDesde)
    SELECT @Semana = DATEPART(wk, @FechaDesde)
    SELECT @Dia = RIGHT('0' + DATEPART(dd, @FechaDesde),2)
    SELECT @DiaSemana = DATEPART(DW, @FechaDesde)
    SELECT @NMes = DATENAME(mm, @FechaDesde)
    SELECT @NMes3l = LEFT(@NMes, 3)
    SELECT @NTrimestre = 'T' + CAST(@Trimestre as CHAR(1)) + '/' + RIGHT(@Año, 2)
    SELECT @NSemana = 'Sem ' +CAST(@Semana AS CHAR(2)) + '/' + RIGHT(RTRIM(CAST(@Año as CHAR(4))),2)
    SELECT @NDia = CAST(@Dia as CHAR(2)) + ' ' + RTRIM(@NMes)
    SELECT @NDiaSemana = DATENAME(dw, @FechaDesde)
    INSERT INTO DWHMonitoreo.dbo.DIM_TIEMPO
    (
        FechaSK,
        Fecha,
        Año,
        Trimestre,
        Mes,
        Semana,
        Dia,
        DiaSemana,
        NTrimestre,
        NMes,
        NMes3L,
        NSemana,
        NDia,
        NDiaSemana
    ) VALUES
    (
        @FechaAAAAMMDD,
        @FechaDesde,
        @Año,
        @Trimestre,
        @Mes,
        @Semana,
        @Dia,
        @DiaSemana,
        @NTrimestre,
        @NMes,
        @NMes3l,
        @NSemana,
        @NDia,
        @NDiaSemana
    )
   
    --Incremento del bucle
    SELECT @FechaDesde = DATEADD(DAY, 1, @FechaDesde)
    END
    COMMIT TRANSACTION

	--drop table Instancia

	--creacion Instancia

	--
	create table DIM_Instancia(
	srk_Instancia int identity (1,1)  primary key clustered,
	nombreInstancia sysname,
	VersionSQL nvarchar (100), 
	CPU_TipoAfinidad nvarchar (10),
	MemoriaAsignadaMB int,
	ServerCollation sysname ,
	ProcesadoresAsignados sysname
	)

	create table DIM_server(
	srk_server int identity (1,1)  primary key clustered,
	NameServer nvarchar (50),
	SistemaOperativo nvarchar (100),
	VersionSistemaOperativo nvarchar (100),
	SystemModel nvarchar (100),
	Procesador nvarchar (100) ,
	Memory int,
	disks nvarchar (100)
	)

	create table DIM_Databases(
	
	)