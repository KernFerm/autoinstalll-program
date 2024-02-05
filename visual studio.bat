@echo off
:: Check for privileges
net session >nul 2>&1
if %errorlevel% == 0 (
    echo Running with administrative privileges.
) else (
    echo Requesting administrative privileges...
    goto :elevate
)

:: Your script starts here
:: Define the URL for Visual Studio Community installer (bootstrapper)
:: Ensure you have the correct URL for the latest bootstrapper
set VSBTURL=https://c2rsetup.officeapps.live.com/c2r/downloadVS.aspx?sku=community&channel=Release&version=VS2022&source=VSLandingPage&cid=2030:9f9f0266-41dd-47d2-a2cf-c7aeede9f53d

:: Download the Visual Studio Community installer (bootstrapper)
echo Downloading Visual Studio Community installer...
curl -o vs_community.exe "%VSBTURL%"

:: Install Visual Studio Community with "Desktop development with C++" and ".NET desktop development" workloads
echo Installing Visual Studio Community...
vs_setup.exe --nocache --wait --noUpdateInstaller --noWeb --allWorkloads --includeRecommended --includeOptional --quiet --norestart

echo Installation complete.

:: Optionally, delete the installer after installation to free up space
echo Deleting Visual Studio Community installer...
del vs_community.exe

echo Installer deleted. Installation process is complete.

pause
goto :eof

:elevate
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
