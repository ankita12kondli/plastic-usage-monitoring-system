@echo off
echo ========================================
echo   Plastic Usage Monitoring System
echo   Deployment and Test Script
echo ========================================
echo.

echo 1. Checking if WAR file exists...
if exist "target\plastic-usage-monitoring.war" (
    echo [SUCCESS] WAR file found: plastic-usage-monitoring.war
    echo [INFO] File size: 
    for %%I in ("target\plastic-usage-monitoring.war") do echo %%~znI MB
) else (
    echo [ERROR] WAR file not found!
    pause
    exit /b
)

echo.
echo 2. Application is ready for deployment!
echo.
echo To deploy to Tomcat:
echo    - Copy target\plastic-usage-monitoring.war to Tomcat's webapps folder
echo    - Start Tomcat server
echo    - Access at: http://localhost:8080/plastic-usage-monitoring/
echo.
echo Test credentials:
echo    Username: admin, Password: password
echo    Username: john_doe, Password: password
echo    Username: jane_smith, Password: password
echo.
echo ========================================
echo Press any key to exit...
pause
