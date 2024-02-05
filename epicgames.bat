@echo off
setlocal

:: Define URL for Epic Games Launcher installer
set EpicGamesURL=https://epicgames-download1.akamaized.net/Builds/UnrealEngineLauncher/Installers/Win32/EpicInstaller-15.17.1.msi?launcherfilename=EpicInstaller-15.17.1.msi

:: Define installation path for Epic Games Launcher (adjust as needed)
set installPathEpicGames=C:\Program Files\Epic Games

:: Change working directory to the script's directory
CD /d %~dp0

echo Scaricamento di Epic Games Launcher...

:: Downloading the Epic Games Launcher installer
echo Downloading Epic Games Launcher installer...
curl -o EpicInstaller.msi "%EpicGamesURL%"

echo Installazione di Epic Games Launcher...
:: Eseguire il file di installazione
:: Nota: I parametri di installazione potrebbero variare. Verifica se esistono opzioni per un'installazione silenziosa.
msiexec /i EpicInstaller.msi /qn INSTALLDIR="%installPathEpicGames%"

echo Installazione completata.

:: Remove the downloaded installer file
echo Rimozione del file di installazione...
del EpicInstaller.msi

echo Pulizia completata.