@echo off
echo Restarting Tomcat...
set CATALINA_HOME=C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46

echo Stopping Tomcat...
call "%CATALINA_HOME%\bin\shutdown.bat"
timeout /t 3 /nobreak >nul

echo Starting Tomcat...
call "%CATALINA_HOME%\bin\startup.bat"
echo Tomcat restarted!
pause
