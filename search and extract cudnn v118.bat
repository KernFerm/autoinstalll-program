@echo off
setlocal enabledelayedexpansion
set ZIPNAME=cudnn-windows-x86_64-8.9.7.29_cuda11-archive.zip
set DESTPATH=%USERPROFILE%\Desktop
set FINALDEST=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8
set FOUND=

for /r C:\ %%i in (%ZIPNAME%) do (
    if exist "%%i" (
        set FOUND=%%i
        goto :unzipFile
    )
)

:unzipFile
if not defined FOUND (
    echo File %ZIPNAME% not found.
    goto :end
)

echo Found %ZIPNAME% at !FOUND!
set "SEVENZIPPATH=C:\Program Files\7-Zip\7z.exe"
if not exist "%SEVENZIPPATH%" (
    echo 7-Zip not found. Please install it or check the path.
    goto :end
)

"%SEVENZIPPATH%" x "!FOUND!" -o"%DESTPATH%" -y
echo Files extracted to %DESTPATH%.

set EXTRACTEDFOLDER=%DESTPATH%\cudnn-windows-x86_64-8.9.7.29_cuda11-archive
if exist "%EXTRACTEDFOLDER%" (
    echo Moving extracted files to %FINALDEST%
    xcopy "%EXTRACTEDFOLDER%\*.*" "%FINALDEST%\" /E /H /C /I /Y
    echo Files moved.
    rd /S /Q "%EXTRACTEDFOLDER%"
    echo Extracted folder deleted from Desktop.
) else (
    echo Extracted folder not found.
)

:end
endlocal

pause

