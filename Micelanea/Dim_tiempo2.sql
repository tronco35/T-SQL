--create database DM_UNAB_v2
--go

use DWHEpicor
go


/*Creación de la tabla*/

--drop table DIM_TIEMPO
--go
--create table DIM_TIEMPO
--(
--    FechaSK int identity (1,1) not null primary key ,
--    Fecha date not null, 
--    Año smallint not null,
--    Trimestre smallint not null,
--    Mes smallint not null,
--    Semana smallint not null,
--    Dia smallint not null,
--    DiaSemana smallint not null,
--    NTrimestre char(7) not null,
--    NMes char(15) not null,
--    NMes3L char(3) not null,
--    NSemana char(10) not null,
--    NDia char(6) not null,
--    NDiaSemana char(10) not null 
--)
--go

/*Script de carga*/
DECLARE @FechaDesde as datetime
DECLARE @Año as smallint, @Trimestre char(2), @Mes smallint
DECLARE @Semana smallint, @Dia smallint, @DiaSemana smallint
DECLARE @NTrimestre char(7), @NMes char(15)
DECLARE @NMes3l char(3)
DECLARE @NSemana char(10), @NDia char(6), @NDiaSemana char(10)
, @FechaHasta as datetime

--Set inicial por si no coincide con los del servidor
--SET DATEFORMAT dmy
--SET DATEFIRST 1

BEGIN TRANSACTION
    --Borrar datos actuales, si fuese necesario
    --TRUNCATE TABLE DIM_TIEMPO
   
    --RAngo de fechas a generar
    SELECT @FechaDesde = CAST(getdate () AS date)
	---CAST(getdate ()- 2555 AS date)-- 7 años atras
   
   SELECT @FechaHasta = CAST(getdate () + 365 AS date) --1 año
   --CAST(CAST(YEAR(GETDATE())+1 AS CHAR(4)) + '1231' AS smalldatetime)
   
    WHILE (@FechaDesde <= @FechaHasta) BEGIN
    --SELECT @FechaAAAAMMDD = YEAR(@FechaDesde)*10000+
    --                        MONTH(@FechaDesde)*100+
    --                        DATEPART(dd, @FechaDesde)
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

    INSERT INTO DIM_TIEMPO
    (
       -- FechaSK,
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
        --@FechaAAAAMMDD,
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