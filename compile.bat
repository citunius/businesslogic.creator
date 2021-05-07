@echo off

rem -----------------------------------------------------
rem Citunius GmbH - 01.05.2021
rem Program to compile business logics from GIT project
rem -----------------------------------------------------

rem color 0A
rem mode con lines=360 cols=180

setlocal enabledelayedexpansion

rem -----------------------------------------------------------------------------------------------
rem ----- Global variables
rem -----------------------------------------------------------------------------------------------
SET DEFAULT_TENANTID=demo
SET DEFAULT_ACCOUNTID=ALL_ACCOUNTS
SET ANT_VERSION=1.10.10
SET ANT_DOWNLOAD_URL=https://downloads.apache.org/ant/binaries/apache-ant-%ANT_VERSION%-bin.zip
SET TOOLS_DIR=tools
SET CURRENT_DIR=%CD%
SET ANT_HOME=%CURRENT_DIR%\%TOOLS_DIR%\apache-ant-%ANT_VERSION%
SET GIT_HOME=%CD%\git

rem -----------------------------------------------------------------------------------------------
rem ----- Script body
rem -----------------------------------------------------------------------------------------------
rem Creating tools dir ...
IF NOT EXIST "%CURRENT_DIR%\%TOOLS_DIR%" (
	mkdir "%CURRENT_DIR%\%TOOLS_DIR%"
)

echo Check Java ...
where java >nul 2>nul
IF %errorlevel%==1 (
    echo [ERROR] Java not found
	echo [ERROR] Business Logic requires at least JDK 1.8.
	pause
	goto :EOF
    exit /b 1
)
rem Check JAVA_HOME variable
if "%JAVA_HOME%" == "" (
    SET "%1=NO_OK"
	echo  [ERROR] JAVA_HOME variable is not set, unable to use it
	goto :EOF
	rem exit /b 1
)

rem Install Apache Ant
IF NOT EXIST "%ANT_HOME%" (
	echo [NOT FOUND] Apache Ant
	echo 
	echo 
	echo 
	echo 
	echo Downloading Apache Ant ...
	powershell -executionpolicy remotesigned -Command "Invoke-WebRequest %ANT_DOWNLOAD_URL% -OutFile %TOOLS_DIR%\apache-ant.zip; Expand-Archive -Force %TOOLS_DIR%\apache-ant.zip %TOOLS_DIR%; Remove-Item %TOOLS_DIR%\apache-ant.zip"
) ELSE (
	echo [FOUND] Apache Ant in %ANT_HOME%
)

dir %GIT_HOME%\*.* /a/b/d/od>C:\TEMP\CHECKFOLDER
FOR /R C:\TEMP\ %%? in (CHECKFOLDER) do (
 IF "%%~z?"=="0" (
  ECHO [WARNING] Git folder %GIT_HOME% is empty. Checkout your business logic into this folder to compile.
 ) ELSE (
	set folder=%GIT_HOME%
    if not defined folder set "folder=%cd%"

    for /d %%a in ("%GIT_HOME%\*") do (
        set "size=0"
        for /f "tokens=3,5" %%b in ('dir /-c /a /w /s "%%~fa\*" 2^>nul ^| findstr /b /c:"  "') do if "%%~c"=="" set "size=%%~b"
        setlocal enabledelayedexpansion
        echo BL: %%~nxa # Size: !size!
        endlocal
    )
 )
)

:askBusinessLogicPath
set "BUSINESSLOGIC_PATH=NOT_DEFINED"
set /P BUSINESSLOGIC_PATH="Provide the GIT repository path to the business logic: "
IF NOT EXIST "%BUSINESSLOGIC_PATH%" (
	echo [ERROR] Path does not exists
	goto askBusinessLogicPath
)
IF NOT EXIST "%BUSINESSLOGIC_PATH%\build.xml" (
	echo [ERROR] File build.xml in path %BUSINESSLOGIC_PATH% not found
	goto askBusinessLogicPath
)

rem Compile Business Logic
cd %BUSINESSLOGIC_PATH%
echo Create business logic package for ...
CALL "%ANT_HOME%\bin\ant" -Dtenantid=%DEFAULT_TENANTID% -Daccountid=%DEFAULT_ACCOUNTID%
echo ##### Returncode: %errorlevel% #####
if errorlevel 1 (
	goto buildFail
)

set ANT_ERROR=%ERRORLEVEL%
if "%ANT_ERROR%"=="0" goto mainEnd
:buildFail
echo *******************************
echo [ERROR] Ant target failed
echo *******************************
pause
EXIT 1

:mainEnd
echo *******************************
echo [OK] Ant target exit normally
echo *******************************

rem -----------------------------------------------------------------------------------------------
rem ----- END: Script body
rem -----------------------------------------------------------------------------------------------

rem EXIT
