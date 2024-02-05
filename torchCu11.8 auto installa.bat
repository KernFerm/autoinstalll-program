@echo off
echo Disinstallazione di torch, torchvision e torchaudio...
pip uninstall torch torchvision torchaudio -y

echo Installazione delle versioni nightly di torch, torchvision e torchaudio...
//pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
# CUDA 11.8
pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu118

echo Operazione completata.
pause
