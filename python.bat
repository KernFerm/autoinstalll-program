@echo off
setlocal

:: Define URLs for software installers
set pythonInstallerURL=https://www.python.org/ftp/python/3.9.13/python-3.9.13-amd64.exe

:: Define installation paths (adjust as needed)
set installPathPython=C:\Users\12\AppData\Local\Programs\Python\Python39

:: Change working directory to the script's directory
CD /d %~dp0

:: Downloading the Python installer
echo Downloading Python installer...
curl -o python_installer.exe "%pythonInstallerURL%"

:: Installing Python
echo Installing Python...
python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 TargetDir="%installPathPython%"

:: Manually adding Python to the system's environment variables
setx PATH "%PATH%;%installPathPython%;%installPathPython%\Scripts"

:: Cleanup temporary files
del python_installer.exe

echo Python installation completed.

endlocal

