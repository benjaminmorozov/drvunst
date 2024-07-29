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

:main
cls
ECHO ==================================================
ECHO Uninstall driver(s) using pnputil
ECHO 1. List all drivers                                                            
ECHO 2. Export all drivers (data) into C:/DRIVERS/
ECHO 3. Uninstall single driver
ECHO 4. Uninstall all drivers
ECHO 0. Exit
ECHO ==================================================
choice /c 12340 /n  
goto choice%errorlevel%

:choice0
Exit

:choice1
cls
ECHO ==================================================
echo Listing drivers:
pnputil /e
ECHO ==================================================
pause
goto main

:choice2
cls
ECHO ==================================================
echo Exporting drivers...
pnputil /export-driver * C:\DRIVERS
echo Done! Opening in explorer...
explorer C:\Drivers
ECHO ==================================================
goto main

:choice3
cls
ECHO ==================================================
echo Listing drivers for selection:
pnputil /e
ECHO ==================================================
echo Select driver:
set /p "Selection=filename: "
echo Uninstalling "%Selection%"...
pnputil /delete-driver "%Selection%" /uninstall /force
pause
goto main

:choice4
ECHO ==================================================
echo Uninstalling all drivers...
for /F "tokens=4" %%i in ('pnputil /e ^| findstr /R inf') do (
    echo Uninstalling %%i...
    pnputil /delete-driver %%i /uninstall /force
)
ECHO ==================================================
goto main