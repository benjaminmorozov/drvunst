:: Benjamín Morozov 2024 pnputil drvunstlite.bat
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
title drvunstlite.bat - Benjamin Morozov 26.7.2024
cls
for /F "tokens=4" %%i in ('pnputil /e ^| findstr /R inf') do (
    echo Uninstalling %%i
    pnputil /delete-driver %%i /uninstall /force
)
echo done
pause