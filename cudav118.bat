@echo off
setlocal

:: Definisci la directory di destinazione
set "destDir=%UserProfile%\Desktop\tempcudav11.8"

:: Crea la cartella se non esiste
if not exist "%destDir%" mkdir "%destDir%"

:: Scarica il file nella directory specificata
curl -o "%destDir%\cuda_11.8.0_windows_network.exe" https://developer.download.nvidia.com/compute/cuda/11.8.0/network_installers/cuda_11.8.0_windows_network.exe

:: Apri la cartella (opzionale, per visualizzazione)
start "" "%destDir%"

:: Esegue l'installazione (l'utente deve attendere il completamento manualmente)
start /wait cmd /c "%destDir%\cuda_11.8.0_windows_network.exe -s -n"



:: Rimuovi l'attributo di sola lettura dalla cartella e il suo contenuto
attrib -R "%destDir%\*.*" /S /D

:: Pulizia: Elimina la cartella tempcudav11.8
rmdir /s /q "%destDir%"


endlocal

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

@echo off
echo Disinstallazione di torch, torchvision e torchaudio...
pip uninstall torch torchvision torchaudio -y

echo Installazione delle versioni nightly di torch, torchvision e torchaudio...
//pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
# CUDA 11.8
pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu118

echo Operazione completata.
pause



