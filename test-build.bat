@echo off
echo Building Plastic Usage Monitoring System...
cd "c:\Plastic usage monitoring system"
C:\maven\apache-maven-3.9.6\bin\mvn clean package -DskipTests
echo.
echo Build completed. Checking for WAR file...
dir target\*.war
echo.
echo If WAR file exists, you can deploy it to Tomcat webapps folder.
pause
