@echo off
REM Check if running as admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell start-process '%0' -verb runas
    exit /b
)

echo WI-FI Profiles And Key Content Extractor
echo --------------------------------------------------------
echo All Rights Reserved By Chitraaksh
echo Any Misuse of this script is not my responsibility
echo Using This Script Without User's Permission is Illegal
echo Any Distrubution for Commerial Purpose is not allowed, Personal Use Only
pause

cls

echo WI-FI Profiles And Key Content Extractor
echo --------------------------------------------------------
echo Listing Saved Networks...

echo --------------------------------------------------------

netsh wlan show profiles | findstr="All User Profile"

echo --------------------------------------------------------

pause

echo Fetching Wi-Fi SSIDs and Passwords...

echo --------------------------------------------------------

for /f "tokens=2 delims=:" %%i in ('netsh wlan show profiles') do (
    setlocal enabledelayedexpansion 
    set "ssid=%%i"
    call :getpass "!ssid:~1!"
    echo --------------------------------------------------------
    endlocal
)


pause
goto :eof

:getpass
set "ssid=%~1"
echo SSID: %ssid%
netsh wlan show profile name="%ssid%" key=clear | findstr /R "Key Content"
goto :eof
REM For Educational Purpose Only
