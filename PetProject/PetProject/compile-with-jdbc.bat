@echo off
echo Compiling PetProject with SQL Server JDBC Driver...

REM Set paths
set CATALINA_HOME=C:\Users\ADMIN\Desktop\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46
set PROJECT_ROOT=D:\YEAR2 ĐAN\LTWEB\PetProject\PetProject
set LIB_DIR=%PROJECT_ROOT%\lib
set WEBAPP_DIR=%CATALINA_HOME%\webapps\PetProject
set CLASSES_DIR=%WEBAPP_DIR%\WEB-INF\classes

REM Create temporary source directory
set TEMP_SRC=C:\tmp\pet_src
if exist "%TEMP_SRC%" rmdir /S /Q "%TEMP_SRC%"
mkdir "%TEMP_SRC%"

REM Copy source files
xcopy "%PROJECT_ROOT%\src\main\java\*" "%TEMP_SRC%\" /E /I

REM Create classes directory
if not exist "%CLASSES_DIR%" mkdir "%CLASSES_DIR%"

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
cd "%PROJECT_ROOT%"
rmdir /S /Q "%TEMP_SRC%"

echo Done! You can now start Tomcat.
pause
