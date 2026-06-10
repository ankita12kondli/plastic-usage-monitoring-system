@echo off
echo ============================================
echo   PLASTIC USAGE MONITORING SYSTEM
echo ============================================
echo.
echo Step 1: Starting server...
echo.

:: Kill any old Java processes
taskkill /F /IM java.exe 2>nul

:: Start server in new window
start "Server" cmd /k "cd /d "%~dp0" && mvn cargo:run"

:: Wait for server to start
echo Step 2: Waiting for server to start (20 seconds)...
timeout /t 20 /nobreak >nul

echo.
echo Step 3: Opening browser...
echo.

:: Open the website
start http://localhost:8082/plastic-usage-monitoring/

echo ============================================
echo   PROJECT IS RUNNING!
echo ============================================
echo.
echo URL: http://localhost:8082/plastic-usage-monitoring/
echo.
echo Login Details:
echo   Admin:  admin / password
echo   User:   john_doe / password
echo.
echo To Stop: Close the "Server" window
echo ============================================
echo.
pause
