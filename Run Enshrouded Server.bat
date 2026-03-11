@echo off

:: ####################################
:: #####   EDIT VARIABLES START   #####
:: ####################################

:: CHANGE TO YOUR SERVERS FOLDER EX: set ServerPath=D:\EnshroudedServer
set ServerPath=D:\EnshroudedServer

:: CHANGE TO YOUR SERVERS APPLICATION EX: set GameExe=enshrouded_server.exe
set GameExe=enshrouded_server.exe

:: DELETE LOG FILES? true=1 or false=0 (default)
set DeleteLogs=0

:: BACKUP FILES? Backs up your savegame file, below, after every crash. true=1 or false=0 (default)
set BackupFiles=0

:: FILE TO BACKUP EX: set SaveFile=D:\EnshroudedServer\savegame\3da63dea
:: NOT NEEDED IF BACKUP IS DISABLED
set SaveFile=D:\EnshroudedServer\savegame\3da63dea

:: CHANGE TO YOUR BACKUP FOLDER EX: set ServerPath=D:\EnshroudedServer\backup
:: NOT NEEDED IF BACKUP IS DISABLED
set BackupPath=D:\EnshroudedServer\backups

:: START SERVER CONSOLE MINIMIZED? true=1(default) or false=0
set StartMin=1

:: ##################################
:: #####   EDIT VARIABLES END   #####
:: ##################################

:: #############################################
:: ####    !!!!!DO NOT EDIT BELOW!!!!!!     ####
:: ####  UNLESS YOU KNOW WHAT YOURE DOING   ####
:: #############################################

mode con: cols=59 lines=36

::AQUA color 3b
::GRAY color 8f
color 3b

set APP_TITLE=Enshrouded Server Program

set FirstStart=1

@set Restarts=0

title %APP_TITLE% - Offline

timeout 1 >nul

echo.
echo.
echo         ###########################################
echo         #                                         #
echo         #  REXXENEXX'S Enshrouded SERVER PROGRAM  #
echo         #              version 1.0                #
if %BackupFiles%==0 echo         #   Backup Savefile [Disabled]            #
if %BackupFiles%==1 echo         #   Backup Savefile [Enabled]             #
if %DeleteLogs%==0 echo         #   Delete Logfiles [Disabled]            #
if %DeleteLogs%==1 echo         #   Delete Logfiles [Enabled]             #
echo         #                                         #
echo         #        -v1.0 Release - 2/5/2024         #
echo         #                                         #
echo         ###########################################
echo.
echo                   (%Restarts% Server Restarts)
echo.

tasklist /FI "IMAGENAME eq %GameExe%" 2>NUL | find /I /N "%GameExe%">NUL

if ERRORLEVEL 1 goto startupserver

if ERRORLEVEL 0 goto serverrunning

:restart

cls

echo.
echo.
echo         ###########################################
echo         #                                         #
echo         #  REXXENEXX'S Enshrouded SERVER PROGRAM  #
echo         #              version 1.0                #
if %BackupFiles%==0 echo         #   Backup Savefile [Disabled]            #
if %BackupFiles%==1 echo         #   Backup Savefile [Enabled]             #
if %DeleteLogs%==0 echo         #   Delete Logfiles [Disabled]            #
if %DeleteLogs%==1 echo         #   Delete Logfiles [Enabled]             #
echo         #                                         #
echo         #        -v1.0 Release - 2/5/2024         #
echo         #                                         #
echo         ###########################################
echo.
echo                   (%Restarts% Server Restarts)
echo.

title %APP_TITLE% - Restarting

echo.
echo      Closing Server if Running...

taskkill /im %GameExe% 1>nul 2>&1

timeout 3 >nul

echo      Done!

echo.
echo      Checking if Server is STILL Running...

tasklist /FI "IMAGENAME eq %GameExe%" 2>NUL | find /I /N "%GameExe%">NUL

if ERRORLEVEL 1 goto startupserver

if ERRORLEVEL 0 goto serverrunning

timeout 1 >nul

:startupserver

echo      Server is Not Running...

if %DeleteLogs%==0 goto SkipDeleteLogFiles

title %APP_TITLE% - Delete Logs

echo.
echo      Deleting Log Files...

del /s "%ServerPath%\logs\*.txt"  >nul 2>&1
del /s "%ServerPath%\logs\*.log"  >nul 2>&1
del /s "%ServerPath%\logs\backup\*.log"  >nul 2>&1

timeout 1 >nul

echo      Done!

:SkipDeleteLogFiles

timeout 1 >nul

:servercmdline

echo.
echo      STARTING SERVER %DATE% %TIME: =0%

if %StartMin%==0 start /REALTIME %ServerPath%\%GameExe%

if %StartMin%==1 start /REALTIME /min %ServerPath%\%GameExe%

timeout 1 >nul

:serverrunning

title %APP_TITLE% - Running

timeout 1 >nul

if %FirstStart% == 1 goto checkagain

title %APP_TITLE% - Checking

timeout 20 >nul

:checkagain

timeout 3 >nul

tasklist /FI "IMAGENAME eq %GameExe%" 2>NUL | find /I /N "%GameExe%">NUL

if ERRORLEVEL 1 goto Process_NotFound

title %APP_TITLE% - Running 

set FirstStart=0

set HH=%TIME: =0%

set HH=%HH:~0,2%

set MI=%TIME:~3,2%

goto checkagain

timeout 1 >nul

goto checkagain

timeout 1 >nul

:BackupAndRestart

title %APP_TITLE% - Restarting

taskkill /im %GameExe% 1>nul 2>&1

timeout 3 >nul

if %BackupFiles%==0 goto SkipBackup

echo.
echo      Backing Up Files...

title %APP_TITLE% - Backing Up

set DATESTAMP=%DATE:~4,2%-%DATE:~7,2%-%DATE:~10,4%
 
set hh=%TIME:~0,2%

if "%TIME:~0,1%"==" " set hh=0%hh:~1,1%

set TIMESTAMP=%hh%%TIME:~3,2%%TIME:~6,2%
 
set DATEANDTIME=%DATESTAMP%_%TIMESTAMP%

copy /Y /V "%SaveFile%" "%BackupPath%\3ad85aea_%DATEANDTIME%"  >nul 2>&1

echo      Backup Finished!

:SkipBackup

timeout 5 >nul

@set /a "Restarts=%Restarts%+1"

goto restart

timeout 1 >nul

:Process_NotFound

title %APP_TITLE% - Restarting

echo.
echo      SERVER IS NOT RUNNING %DATE% %TIME: =0%
echo.
echo      Initiating Restart...

goto BackupAndRestart

@exit
