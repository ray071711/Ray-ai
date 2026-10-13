@echo off
chcp 65001 >nul
cd /d "%~dp0"
py -3 main.py --lan
echo.
echo Ray AI 서버를 시작하지 못했습니다. Python 설치와 README를 확인해 주세요.
pause
