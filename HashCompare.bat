@echo off
chcp 65001
title HashCompare
color 0A
cls
echo ==============================
echo      Algorithmus wählen
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
echo      Methode wählen
echo ==============================
echo.
echo [1] zwei Dateien vergleichen
echo [2] Datei mit Hash-String vergleichen
echo.
choice /C 12 /n /M ":"

if errorlevel 2 goto 2
if errorlevel 1 goto 1

:1
cls
echo ==============================
echo         Pfad Datei 1
echo ==============================
echo.
set /p pfad1=: 
echo.
cls
echo ==============================
echo         Pfad Datei 2
echo ==============================
echo.
set /p pfad2=: 
echo.
cls
echo Berechnung Datei 1... 
powershell Get-FileHash -path %pfad1% -Algorithm %algo%
echo Berechnung Datei 2... 
powershell -Command Get-FileHash -path %pfad2% -Algorithm %algo%
echo Berechnung der Übereinstimmung... 
powershell -NoProfile -Command ^ "if ((Get-FileHash -Path '%pfad1%' -Algorithm %algo%).Hash -eq (Get-FileHash -Path '%pfad2%' -Algorithm %algo%).Hash) { Write-Host '✅ Dateien sind IDENTISCH' } else { Write-Host '❌ Dateien unterscheiden sich' }"
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
echo          Pfad Datei
echo ==============================
echo.
set /p pfad1=: 
echo.
cls
echo Angegebener Hash: %hashstring%
echo Berechnung der Datei... 
powershell Get-FileHash -path %pfad1% -Algorithm %algo%
echo Berechnung der Übereinstimmung... 
powershell -NoProfile -Command ^ "if ((Get-FileHash -Path '%pfad1%' -Algorithm %algo%).Hash -eq '%hashstring%') { Write-Host '✅ Datei entspricht dem HASH' } else { Write-Host '❌ Datei entspricht NICHT dem HASH' }"
goto beenden

:beenden
pause
exit