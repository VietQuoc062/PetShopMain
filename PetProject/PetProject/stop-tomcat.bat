@echo off
echo Stopping Tomcat...
set CATALINA_HOME=C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46
call "%CATALINA_HOME%\bin\shutdown.bat"
echo Tomcat stopped!
pause
