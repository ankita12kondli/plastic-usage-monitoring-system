@echo off
chcp 65001 >nul
echo.
echo =========================================
echo  PLASTIC USAGE MONITORING SYSTEM
echo =========================================
echo.
echo  Starting server...
echo.
echo  URL: http://localhost:8082/plastic-usage-monitoring/
echo.
echo  Login: admin / password
echo.
echo =========================================
echo.

:: Start server in background
start "Tomcat Server" cmd /c "mvn cargo:run"

:: Wait for server to start
echo Waiting for server to start (15 seconds)...
timeout /t 15 /nobreak >nul

:: Open browser
echo Opening browser...
start http://localhost:8082/plastic-usage-monitoring/

echo.
echo Browser opened! Server is running.
echo.
echo To stop: Close the Tomcat Server window
echo.
pause
