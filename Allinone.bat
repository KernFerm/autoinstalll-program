@echo off
setlocal

:: Define URLs for software installers
set LibreOfficeURL=https://tdf.mirror.garr.it/libreoffice/stable/7.6.4/win/x86_64/LibreOffice_7.6.4_Win_x86-64.msi
set braveInstallerURL=https://referrals.brave.com/latest/BraveBrowserSetup.exe
set gitInstallerURL=https://example.com/Git64-bit.exe
set dotNetInstallerURL=https://download.microsoft.com/download/4/b/2/4b21528a-8944-4a9e-b9d4-6474125e540c/NDP481-x86-x64-AllOS-ENU.exe
set discordInstallerURL=https://dl.discordapp.net/distro/app/stable/win/x86/1.0.9016/DiscordSetup.exe
set sevenZipInstallerURL=https://www.7-zip.org/a/7z2301-x64.exe
set directXWebInstallerURL=https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe
set pythonInstallerURL=https://www.python.org/ftp/python/3.9.13/python-3.9.13-amd64.exe

:: Define installation paths (adjust as needed)
set installPathBrave=C:\Program Files\Brave
set installPathGit=C:\Program Files\Git
set installPathDiscord=C:\Program Files\Discord
set installPath7Zip=C:\Program Files\7-Zip
set installPathLibreOffice=C:\Program Files\LibreOffice
set installPathPython=C:\Program Files\Python

:: Change working directory to the script's directory
CD /d %~dp0

echo.
echo Microsoft Visual C++ All-In-One Runtimes by W1zzard @ TechPowerUp
echo https://www.techpowerup.com/download/visual-c-redistributable-runtime-package-all-in-one/
echo.
echo Installing runtime packages...

:: Check system architecture (32-bit or 64-bit)
set IS_X64=0 && if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set IS_X64=1) else (if "%PROCESSOR_ARCHITEW6432%"=="AMD64" (set IS_X64=1))

if "%IS_X64%" == "1" (
    goto X64
) else (
    goto X86
)

:X86
echo 2012...
start /wait vcredist2012_x86.exe /passive /norestart
echo 2013...
start /wait vcredist2013_x86.exe /passive /norestart
echo 2015 - 2022...
start /wait vcredist2015_2017_2019_2022_x86.exe /passive /norestart
goto END

:X64
echo 2012...
start /wait vcredist2012_x86.exe /passive /norestart
start /wait vcredist2012_x64.exe /passive /norestart
echo 2013...
start /wait vcredist2013_x86.exe /passive /norestart
start /wait vcredist2013_x64.exe /passive /norestart
echo 2015 - 2022...
start /wait vcredist2015_2017_2019_2022_x86.exe /passive /norestart
start /wait vcredist2015_2017_2019_2022_x64.exe /passive /norestart
goto END

:END
echo.
echo Installation completed successfully

:: Download the Brave Browser installer
echo Downloading Brave Browser installer...
curl -o brave_installer.exe "%braveInstallerURL%"

:: Install Brave Browser silently
echo Installing Brave Browser...
brave_installer.exe

:: Cleanup temporary files
del brave_installer.exe


echo Brave Browser installation completed.


:: Set the path to the Git 64-bit installer in the same directory as the script
set gitInstallerPath=%~dp0Git64-bit.exe

:: Check if the Git installer file exists in the script's directory
if not exist "%gitInstallerPath%" (
    echo Error: Git installer file not found.
    exit /b 1
)

:: Install Git 64-bit silently
echo Installing Git 64-bit...
"%gitInstallerPath%" /SILENT /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"

:: Check for installation errors
if %errorlevel% neq 0 (
    echo Error: Git 64-bit installation failed.
    exit /b 1
)

echo Git 64-bit installation completed.

echo Installing .NET Framework 4.8...
:: Download the .NET Framework installer
echo Downloading .NET Framework installer...
curl -o dotnet_installer.exe "%dotNetInstallerURL%"

:: Install .NET Framework silently
echo Installing .NET Framework...
dotnet_installer.exe /q /norestart

:: Cleanup temporary files
del dotnet_installer.exe

echo .NET Framework installation completed.




endlocal

setlocal

set installerURL=https://dl.discordapp.net/distro/app/stable/win/x86/1.0.9016/DiscordSetup.exe
set installPath=C:\Program Files\Discord

echo Installing Discord...

:: Creazione della cartella di installazione
if not exist "%installPath%" (
    mkdir "%installPath%"
)

:: Download dell'installer di Discord
echo Downloading Discord installer...
curl -o discord_installer.exe "%installerURL%"

:: Installazione di Discord
echo Installing Discord...
discord_installer.exe /S /D="%installPath%"

:: Pulizia dei file temporanei
del discord_installer.exe

echo Discord installation completed.

endlocal

@echo off
setlocal

:: Set the URL for the 7-Zip installer
set sevenZipInstallerURL=https://www.7-zip.org/a/7z2301-x64.exe
set installPath7Zip=C:\Program Files\7-Zip

echo Installing 7-Zip...

:: Create the installation folder
if not exist "%installPath7Zip%" (
    mkdir "%installPath7Zip%"
)

:: Download the 7-Zip installer
echo Downloading 7-Zip installer...
curl -o 7z_installer.exe "%sevenZipInstallerURL%"

:: Install 7-Zip
echo Installing 7-Zip...
7z_installer.exe /S /D="%installPath7Zip%"

:: Cleanup temporary files
del 7z_installer.exe

echo 7-Zip installation completed.

endlocal

setlocal

:: Set the URL for the DirectX Web Installer
set directXWebInstallerURL=https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe

echo Installing DirectX Web Installer...

:: Download the DirectX Web Installer
echo Downloading DirectX Web Installer...
curl -o dxwebsetup.exe "%directXWebInstallerURL%"

:: Install DirectX Web
echo Installing DirectX Web Installer...
dxwebsetup.exe /Q

:: Cleanup temporary files
del dxwebsetup.exe

echo DirectX Web installation completed.

endlocal
pause