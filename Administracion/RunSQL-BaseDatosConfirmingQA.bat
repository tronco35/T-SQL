@echo ON
set Instacia=180.168.120.232,1433
@echo .
@echo .
@echo .
@echo -----------------------------------------------------------------------
@echo                 Ya hizo el backup?
@echo                 El cambio se va a ejecutar en %Instacia%
@echo -----------------------------------------------------------------------
@echo .
@echo .
pause
@echo ON
REM set RutaCaso=HCB201411070037\BasedeDatos

REM set RutaEjecuta= D:\temp\SQL\boinfnbl\Cambios20141110_1\%RutaCaso%
REM set RutaLog=D:\temp\SQL\boinfnbl\Cambios20141110_1\HCB201411070037\BasedeDatos\

set path=%path%;%ProgramFiles%\Microsoft SQL Server\100\Tools\Binn


REM CD %RutaEjecuta%

FOR /D %%x in (*) DO (

REM CD %RutaEjecuta%\%%x
CD %%x

for /R %%F in (*.sq?) do (ECHO %%F & sqlcmd.exe -i"%%F" -S%Instacia% -E -d%%x -f i:65001,o:65001 & echo _ )>>..\Sql_Confirming%%x.log
CD ..

)
REM CD %RutaEjecuta% 
REM CD ..


