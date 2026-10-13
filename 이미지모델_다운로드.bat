@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
set "MODEL_DIR=%~dp0ComfyUI_windows_portable\ComfyUI\models\checkpoints"
set "MODEL_FILE=%MODEL_DIR%\v1-5-pruned-emaonly-fp16.safetensors"
if not exist "%MODEL_DIR%" mkdir "%MODEL_DIR%"
if exist "%MODEL_FILE%" (
  echo 이미 이미지 모델 파일이 있습니다.
  goto start_comfy
)
echo Stable Diffusion 1.5 모델을 공식 Hugging Face 저장소에서 받습니다. 약 2.13GB입니다.
echo 다운로드가 끝날 때까지 이 창을 닫지 마세요.
curl.exe -L --fail --retry 5 --retry-delay 3 -C - "https://huggingface.co/Comfy-Org/stable-diffusion-v1-5-archive/resolve/main/v1-5-pruned-emaonly-fp16.safetensors" -o "%MODEL_FILE%"
if errorlevel 1 (
  echo 다운로드가 중단되었거나 실패했습니다. 다시 실행하면 이어받기를 시도합니다.
  pause
  exit /b 1
)
:start_comfy
echo 모델 준비 완료. ComfyUI를 시작합니다. 이 창을 켜 두세요.
call "%~dp0ComfyUI_windows_portable\run_nvidia_gpu.bat"
