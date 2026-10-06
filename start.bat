@echo off
cd /d "%~dp0"
docker compose up -d --build
if errorlevel 1 goto :err
echo.
echo Istakoza POS is running at http://localhost:8080
echo Data is stored in: %CD%\data
start "" http://localhost:8080
exit /b 0
:err
echo.
echo Docker failed to start. Make sure Docker Desktop is installed and running.
pause
exit /b 1
