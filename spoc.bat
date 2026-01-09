@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM =====================================
REM Websites oeffnen
REM =====================================
start "" "https://workplace.srgssr.ch/login"
start "" "https://gethelp.srgssr.ch/"
start "" "https://itsm.srgssr.ch/XPert.aspx"
start "" "https://srgssr.sharepoint.com/sites/tpc-helpdesk/SitePages/Home.aspx?e=4%3a5bb58d0af42645b191aea0238a77d187&web=1&sharingv2=true&fromShare=true&at=9&CID=e8deae14-e5b1-4018-a72d-7990afc569b7"
start "" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Google Chrome.lnk" "https://osccweb.media.int/agentportal/#login"


REM =====================================
REM Kurze Pause vor Apps
REM =====================================
timeout /t 2 >nul

REM =====================================
REM Apps starten + warten bis Prozess laeuft
REM =====================================

call :StartAndWait "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SCCM Remote Control 5.0.8825.lnk" "CmRcViewer.exe" 60
call :StartAndWait "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Remote Desktop Connection.lnk" "mstsc.exe" 60
call :StartAndWait "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TeamViewer.lnk" "TeamViewer.exe" 60

echo.
echo Alle Programme wurden gestartet.
echo.
pause
exit /b 0


REM ==========================================================
REM StartAndWait <link_or_exe> <processname> <timeoutSeconds>
REM ==========================================================
:StartAndWait
set "APP_PATH=%~1"
set "PROC_NAME=%~2"
set "TIMEOUT=%~3"

echo.
echo Starte: %APP_PATH%
start "" "%APP_PATH%"

set /a elapsed=0

:wait_loop
tasklist /FI "IMAGENAME eq %PROC_NAME%" 2>nul | find /I "%PROC_NAME%" >nul
if %errorlevel%==0 (
    echo OK: %PROC_NAME% laeuft.
    exit /b 0
)

if %elapsed% GEQ %TIMEOUT% (
    echo WARNUNG: %PROC_NAME% nach %TIMEOUT%s nicht gefunden. Weiter...
    exit /b 0
)

timeout /t 1 >nul
set /a elapsed+=1
goto wait_loop
