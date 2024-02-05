@echo off

set "github_repo=https://github.com/zcban1/dxcam-mod"
set "install_folder=dxcam-mod"

echo Scaricamento del repository da GitHub...
git clone %github_repo% %install_folder%

echo Installazione della libreria per Python...
cd %install_folder%
pip install .

echo Eliminazione della cartella del repository...
cd ..
rd /s /q %install_folder%

echo Operazione completata.
