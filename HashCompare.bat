@echo off
chcp 65001
title HashCompare
color 0A
cls
echo ==============================
echo      choose algorithm
echo ==============================
echo.
echo [1] SHA1
echo [2] SHA256
echo [3] SHA384
echo [4] SHA512
echo [5] MD5
echo.
choice /C 12345 /n /M ":"

set "choice=%ERRORLEVEL%"
if %choice%==1 set "algo=SHA1"
if %choice%==2 set "algo=SHA256"
if %choice%==3 set "algo=SHA384"
if %choice%==4 set "algo=SHA512"
if %choice%==5 set "algo=MD5"


cls
echo ==============================
echo        choose method
echo ==============================
echo.
echo [1] Compare two files
echo [2] Compare file with checksum
echo.
choice /C 12 /n /M ":"

if errorlevel 2 goto 2
if errorlevel 1 goto 1

:1
cls
echo ==============================
echo         file path 1
echo ==============================
echo.
set /p pfad1=: 
echo.
cls
echo ==============================
echo         file path 2
echo ==============================
echo.
set /p pfad2=: 
echo.
cls
echo Calculating file 1... 
powershell Get-FileHash -path %pfad1% -Algorithm %algo%
echo Calculating file 2... 
powershell -Command Get-FileHash -path %pfad2% -Algorithm %algo%
echo Comparing... 
powershell -NoProfile -Command ^ "if ((Get-FileHash -Path '%pfad1%' -Algorithm %algo%).Hash -eq (Get-FileHash -Path '%pfad2%' -Algorithm %algo%).Hash) { Write-Host '✅ files are identical' } else { Write-Host '❌ files are NOT identical' }"
goto beenden

:2
cls
echo ==============================
echo         Hash-String
echo ==============================
echo.
set /p hashstring=: 
echo.
cls
echo ==============================
echo           file path
echo ==============================
echo.
set /p pfad1=: 
echo.
cls
echo Given checksum: %hashstring%
echo Calculating the file... 
powershell Get-FileHash -path %pfad1% -Algorithm %algo%
echo Comparing... 
powershell -NoProfile -Command ^ "if ((Get-FileHash -Path '%pfad1%' -Algorithm %algo%).Hash -eq '%hashstring%') { Write-Host '✅ The file is matching the checksum' } else { Write-Host '❌ The file does NOT match the checksum' }"
goto beenden

:beenden
pause
exit