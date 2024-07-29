:: Benjamín Morozov 2024 pnputil drvunst.bat
::pnputil /e | findstr /R inf > driverlist_before.txt
::for /F "tokens=4" %i in ('pnputil /e ^| findstr /R inf') do echo %%i >> driverlist_before.txt
::for /l %%i in (1,1,111) do (
::    pnputil /delete-driver oem%%i.inf /uninstall /force
::)
if not "%1"=="am_admin" (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
    exit /b
)
@echo off
title drvunst.bat - Benjamin Morozov 26.7.2024
cls

:main
ECHO ==================================================
ECHO Uninstall driver(s) using pnputil
ECHO 1. List all drivers                                                            
ECHO 2. Export all drivers (data) into C:/DRIVERS/
ECHO 3. Uninstall single driver
ECHO 4. Uninstall all drivers
ECHO 0. Exit
ECHO ==================================================
set /p "Selection=op: " || set "Selection=nothing"
if "%Selection%"=="nothing" ECHO "%Selection%" is not valid please try again else if "%Selection%"=="1" goto list else if "%Selection%"=="2" goto export else if "%Selection%"=="3" goto uninstone else if "%Selection%"=="4" goto uninstall else if "%Selection%"=="0" goto Exit else goto Exit


:list
echo Listing...
pnputil /e
goto main

:export
echo Exporting...
pnputil /export-driver * C:\Drivers
goto main

:uninstone
echo err:not implemented
goto main

:uninstall
for /F "tokens=4" %%i in ('pnputil /e ^| findstr /R inf') do (
    echo Uninstalling %%i
    pnputil /delete-driver %%i /uninstall /force
)
goto main

echo done
pause