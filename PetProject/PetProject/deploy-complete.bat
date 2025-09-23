@echo off
echo Complete PetProject Deployment with SQL Server Support...

REM Set paths
set CATALINA_HOME=C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46
set LIB_DIR=%~dp0lib
set WEBAPP_DIR=%CATALINA_HOME%\webapps\PetProject
set CLASSES_DIR=%WEBAPP_DIR%\WEB-INF\classes

REM Stop Tomcat if running
echo Stopping Tomcat...
call "%CATALINA_HOME%\bin\shutdown.bat"
timeout /t 3 /nobreak >nul

REM Clean old deployment
echo Cleaning old deployment...
if exist "%WEBAPP_DIR%" rmdir /S /Q "%WEBAPP_DIR%"
if exist "%CATALINA_HOME%\work\Catalina\localhost\PetProject" rmdir /S /Q "%CATALINA_HOME%\work\Catalina\localhost\PetProject"

REM Create new deployment
echo Creating new deployment...
mkdir "%WEBAPP_DIR%"
mkdir "%CLASSES_DIR%"

REM Copy webapp files
echo Copying webapp files...
xcopy "%~dp0src\main\webapp\*" "%WEBAPP_DIR%\" /E /I

REM Copy JDBC driver to webapp lib
echo Copying JDBC driver...
mkdir "%WEBAPP_DIR%\WEB-INF\lib"
copy "%~dp0lib\mssql-jdbc-12.4.2.jre8.jar" "%WEBAPP_DIR%\WEB-INF\lib\"

REM Create temporary source directory for compilation
set TEMP_SRC=C:\tmp\pet_src
if exist "%TEMP_SRC%" rmdir /S /Q "%TEMP_SRC%"
mkdir "%TEMP_SRC%"

REM Copy source files
xcopy "%~dp0src\main\java\*" "%TEMP_SRC%\" /E /I

REM Compile with JDBC driver in classpath
echo Compiling Java files...
cd "%TEMP_SRC%"
javac -encoding UTF-8 -cp "%CATALINA_HOME%\lib\*;%LIB_DIR%\mssql-jdbc-12.4.2.jre8.jar" -d "%CLASSES_DIR%" com\petweb\model\Pet.java com\petweb\model\Review.java com\petweb\database\DatabaseConnection.java com\petweb\dao\ReviewDAO.java com\petweb\servlet\PetDetailServlet.java com\petweb\servlet\ReviewServlet.java

if %ERRORLEVEL% EQU 0 (
    echo Compilation successful!
) else (
    echo Compilation failed!
    pause
    exit /b 1
)

REM Clean up
cd "%~dp0"
rmdir /S /Q "%TEMP_SRC%"

REM Start Tomcat
echo Starting Tomcat...
call "%CATALINA_HOME%\bin\startup.bat"

echo.
echo Deployment completed!
echo.
echo Your application is available at:
echo - http://localhost:8080/PetProject/pet-detail
echo - http://localhost:8080/PetProject/petDetail.jsp
echo.
echo Make sure SQL Server is running and database is created!
pause
