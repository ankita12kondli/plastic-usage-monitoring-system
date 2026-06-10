@echo off
echo ========================================
echo   Plastic Usage Monitoring System
echo   Starting Server and Opening Browser...
echo ========================================
echo.

:: Start a background timer to open the browser after 8 seconds (giving Tomcat time to start)
start /b cmd /c "timeout /t 8 >nul && start http://localhost:8082/plastic-usage-monitoring/"

:: Compile and run the project
mvn package cargo:run
