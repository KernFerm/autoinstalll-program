@echo off
setlocal

:: Define URLs for software installers
set LibreOfficeURL=https://tdf.mirror.garr.it/libreoffice/stable/7.6.4/win/x86_64/LibreOffice_7.6.4_Win_x86-64.msi

:: Define installation paths (adjust as needed)
set installPathLibreOffice=C:\Program Files\LibreOffice

:: Change working directory to the script's directory
CD /d %~dp0

echo Scaricamento di LibreOffice...

:: Downloading the LibreOffice installer
echo Downloading LibreOffice installer...
curl -o LibreOffice_7.6.4_Win_x86-64.msi "%LibreOfficeURL%"

echo Installazione di LibreOffice...
:: Execute the installation file
msiexec /i LibreOffice_7.6.4_Win_x86-64.msi /qn INSTALLDIR="%installPathLibreOffice%"

echo Installazione completata.

:: Delete the downloaded installer after installation
echo Deleting LibreOffice installer...
del LibreOffice_7.6.4_Win_x86-64.msi

echo Installer deleted. Installation process is complete.






