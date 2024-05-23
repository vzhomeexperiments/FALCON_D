rem *************************************************
rem *** This script will:
rem *** 0. Check if MT4 is running and kill the sessions
rem *** 1. Update ini script with the new dates for optimization and credentials
rem *** 2. Starts the terminal optimization after waiting 5 seconds ***
rem *** 3. Starts all terminals again after waiting 30 seconds ***
rem *************************************************

rem *** Important:
rem *** Before running this script set Execution Policy of PowerShell
rem *** Run PowerShell As Administrator
rem *** Set-ExecutionPolicy Unrestricted

@echo off
setlocal

rem *************************************************
rem *** 0. Check if MT4 is running and kill the session
rem *************************************************
:: Name of the program executable
set "programName=terminal.exe"

:: Check if any instance of the program is running
tasklist /FI "IMAGENAME eq %programName%" 2>NUL | find /I "%programName%" >NUL

:: If the program is running, terminate all instances
if "%ERRORLEVEL%"=="0" (
    echo %programName% is running. Terminating all instances.
    taskkill /F /IM %programName%
    if "%ERRORLEVEL%"=="0" (
        echo All instances of %programName% have been terminated successfully.
    ) else (
        echo Failed to terminate all instances of %programName%.
    )
) else (
    echo %programName% is not running.
)

rem *************************************************
rem *** 1. Update ini script with the new dates for optimization and passwords
rem *************************************************

:: Get today's date in YYYY.MM.DD format using PowerShell and write it to the ini file
for /f %%I in ('powershell -NoProfile -Command "(Get-Date).AddMonths(-1).ToString('yyyy.MM.dd')"') do set TODAY=%%I

:: Get the date 3 months ago in YYYY.MM.DD format using PowerShell
for /f %%I in ('powershell -NoProfile -Command "(Get-Date).AddMonths(-4).ToString('yyyy.MM.dd')"') do set THREE_MONTHS_AGO=%%I

:: Write dates to the ini file
:: Define the path to your initiation file
set "INIT_FILE=%PATH_DSS_Repo%\FALCON_D\AUTO_BACKTEST\set_opt_falcond.ini"

:: Update the TestToDate parameter in the initiation file TestFromDate
if exist "%INIT_FILE%" (
    powershell -NoProfile -Command "(Get-Content '%INIT_FILE%') -replace 'TestFromDate=\d{4}.\d{2}.\d{2}', 'TestFromDate=%THREE_MONTHS_AGO%' | Set-Content '%INIT_FILE%'"
    powershell -NoProfile -Command "(Get-Content '%INIT_FILE%') -replace 'TestToDate=\d{4}.\d{2}.\d{2}', 'TestToDate=%TODAY%' | Set-Content '%INIT_FILE%'"
	:: Use PowerShell to replace the Login value
	powershell -NoProfile -Command "(Get-Content '%INIT_FILE%') -replace 'Login=.*', 'Login=%USR_T1%' | Set-Content '%INIT_FILE%'"
    :: Use PowerShell to replace the Password value
	powershell -NoProfile -Command "(Get-Content '%INIT_FILE%') -replace 'Password=.*', 'Password=%PS_T1%' | Set-Content '%INIT_FILE%'"
) else (
    echo Initiation file not found: %INIT_FILE%
	exit
)



rem *************************************************
rem *** 2. Starts the terminal optimization after waiting 5 seconds ***
rem *************************************************

ping localhost -n 5

start "1" "%PATH_T1_T%\terminal.exe" /portable "%INIT_FILE%"

:: Replace credentials to their dummy state
:: Use PowerShell to replace the Login value
	::powershell -NoProfile -Command "(Get-Content '%INIT_FILE%') -replace 'Login=.*', 'Login=123478' | Set-Content '%INIT_FILE%'"
    :: Use PowerShell to replace the Password value
	::powershell -NoProfile -Command "(Get-Content '%INIT_FILE%') -replace 'Password=.*', 'Password="ABCdaepaswD"' | Set-Content '%INIT_FILE%'"

endlocal
rem *************************************************
rem *** 3. Starts all terminals again after waiting 30 seconds ***
rem *************************************************

ping localhost -n 10

call "%PATH_STUP%\MetaTraderAutoLaunch.cmd"


exit
