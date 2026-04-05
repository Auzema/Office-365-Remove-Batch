@echo off
setlocal EnableDelayedExpansion
title Office Terminator v1.0 - Because Microsoft Won't Let You Leave
color 0E

:: ============================================================
:: Check for Administrator privileges
:: ============================================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo ============================================================
    echo   ERROR: This script must be run as Administrator!
    echo   Right-click the file and select "Run as administrator"
    echo.
    echo   Even uninstalling requires admin rights...
    echo   Classic Microsuck move.
    echo ============================================================
    pause
    exit /b 1
)

echo.
echo  ============================================================
echo  #   ___  __  __ _            _____                   _     #
echo  #  / _ \/ _|/ _(_) ___ ___ |_   _|__ _ __ _ __ ___ (_)    #
echo  # | | | | |_| |_| |/ __/ _ \  | |/ _ \ '__| '_ ` _ \| |  #
echo  # | |_| |  _|  _| | (_|  __/  | |  __/ |  | | | | | | |  #
echo  #  \___/|_| |_| |_|\___\___|  |_|\___|_|  |_| |_| |_|_|  #
echo  #                                                          #
echo  #          "I hate Microsuck" Edition  v1.0                #
echo  ============================================================
echo.
echo  ============================================================
echo  #              OFFICE TERMINATOR v1.0                      #
echo  #     The tool Microsoft doesn't want you to have          #
echo  ============================================================
echo.
echo  DESCRIPTION:
echo    A universal batch script that automatically detects and
echo    completely removes Microsoft Office 365 / 2021 / 2019 /
echo    2016 / 2013 from any Windows PC. Because Microsoft made
echo    uninstalling harder than installing. Fuck Microsoft.
echo.
echo  FEATURES:
echo    [1] Auto-detects Admin privileges
echo    [2] Kills all running Office processes (Word, Excel, etc.)
echo    [3] Stops and deletes Click-to-Run services
echo    [4] Registry-based install path detection (32-bit + 64-bit)
echo    [5] Common path scanning and removal
echo    [6] User-level Office data cleanup
echo    [7] Scheduled tasks removal
echo    [8] Registry entries cleanup
echo    [9] Installer and patch cache clearing
echo   [10] Works on ANY Windows machine (7/8/10/11)
echo   [11] Supports Office 2013, 2016, 2019, 2021, and 365
echo   [12] Confirmation prompt to prevent accidental runs
echo.
echo  ============================================================
echo.
echo  WARNING: This will NUKE all Microsoft Office products!
echo.
set /p confirm="  Type YES to send Office to hell: "
if /i not "%confirm%"=="YES" (
    echo.
    echo  Fine, Office lives another day... for now.
    pause
    exit /b 0
)

echo.
echo  "Dear Microsoft, it's not me, it's you." - Everyone
echo.
timeout /t 2 /nobreak >nul

echo ============================================================
echo  [Step 1/6] Closing running Office applications...
echo  "You can't uninstall me!" - Office, probably
echo ============================================================
for %%P in (
    WINWORD EXCEL POWERPNT OUTLOOK ONENOTE MSACCESS MSPUB LYNC
    Teams ONENOTEM VISIO GROOVE INFOPATH winproj
) do (
    taskkill /f /im %%P.exe >nul 2>&1 && echo   Terminated: %%P.exe  -- Get rekt.
)
timeout /t 2 /nobreak >nul

echo.
echo ============================================================
echo  [Step 2/6] Stopping and removing Office services...
echo  "I hate Microsuck and their Click-to-Run garbage"
echo ============================================================
for %%S in (ClickToRunSvc OfficeSvc "Microsoft Office Click-to-Run Service") do (
    sc stop %%S >nul 2>&1 && echo   Stopped: %%S
    sc delete %%S >nul 2>&1 && echo   Deleted: %%S  -- Good riddance.
)
timeout /t 2 /nobreak >nul

echo.
echo ============================================================
echo  [Step 3/6] Detecting and removing Office installations...
echo  "Finding where Microsoft hid all their crap..."
echo ============================================================

set "found=0"

:: --- Registry-based detection ---
set "regKeys="
set "regKeys=!regKeys! "HKLM\SOFTWARE\Microsoft\Office\ClickToRun" /v InstallPath"
set "regKeys=!regKeys! "HKLM\SOFTWARE\Microsoft\Office\16.0\Common\InstallRoot" /v Path"
set "regKeys=!regKeys! "HKLM\SOFTWARE\Microsoft\Office\15.0\Common\InstallRoot" /v Path"
set "regKeys=!regKeys! "HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun" /v InstallPath"
set "regKeys=!regKeys! "HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\16.0\Common\InstallRoot" /v Path"

for %%R in (!regKeys!) do (
    for /f "tokens=2*" %%A in ('reg query %%R 2^>nul ^| findstr /i "Path InstallPath"') do (
        if exist "%%B" (
            echo   [Registry] Found: %%B
            rd /s /q "%%B" 2>nul && echo   [NUKED]    %%B
            set "found=1"
        )
    )
)

:: --- Common file path detection ---
set "paths="
set "paths=!paths! "%ProgramFiles%\Microsoft Office""
set "paths=!paths! "%ProgramFiles%\Microsoft Office 15""
set "paths=!paths! "%ProgramFiles%\Microsoft Office 16""
set "paths=!paths! "%ProgramFiles(x86)%\Microsoft Office""
set "paths=!paths! "%ProgramFiles(x86)%\Microsoft Office 15""
set "paths=!paths! "%ProgramFiles(x86)%\Microsoft Office 16""
set "paths=!paths! "%CommonProgramFiles%\Microsoft Shared\ClickToRun""
set "paths=!paths! "%CommonProgramFiles%\Microsoft Shared\OFFICE16""
set "paths=!paths! "%CommonProgramFiles%\Microsoft Shared\OFFICE15""
set "paths=!paths! "%CommonProgramFiles(x86)%\Microsoft Shared\ClickToRun""
set "paths=!paths! "%CommonProgramFiles(x86)%\Microsoft Shared\OFFICE16""
set "paths=!paths! "%CommonProgramFiles(x86)%\Microsoft Shared\OFFICE15""
set "paths=!paths! "%ProgramData%\Microsoft\ClickToRun""
set "paths=!paths! "%ProgramData%\Microsoft\Office""

for %%D in (!paths!) do (
    if exist %%D (
        echo   [Path]  Found: %%~D
        rd /s /q %%~D 2>nul && echo   [NUKED] %%~D
        set "found=1"
    )
)

:: --- User-level Office data ---
set "userPaths="
set "userPaths=!userPaths! "%LocalAppData%\Microsoft\Office""
set "userPaths=!userPaths! "%LocalAppData%\Microsoft\OneDrive""
set "userPaths=!userPaths! "%AppData%\Microsoft\Office""
set "userPaths=!userPaths! "%AppData%\Microsoft\Templates""

for %%D in (!userPaths!) do (
    if exist %%D (
        echo   [User]  Found: %%~D
        rd /s /q %%~D 2>nul && echo   [NUKED] %%~D
        set "found=1"
    )
)

if "!found!"=="0" (
    echo   No Office folders found. Maybe it was never here?
    echo   Or maybe Microsoft is hiding them. Wouldn't surprise me.
)

echo.
echo ============================================================
echo  [Step 4/6] Removing Office scheduled tasks...
echo  "Stop phoning home, Microsoft. Nobody likes a stalker."
echo ============================================================
for %%T in (
    "\Microsoft\Office\Office Automatic Updates 2.0"
    "\Microsoft\Office\Office ClickToRun Service Monitor"
    "\Microsoft\Office\Office Feature Updates"
    "\Microsoft\Office\Office Feature Updates Logon"
    "\Microsoft\Office\Office Serviceability Manager"
    "\Microsoft\Office\OfficeTelemetryAgentFallBack2016"
    "\Microsoft\Office\OfficeTelemetryAgentLogOn2016"
) do (
    schtasks /delete /tn %%T /f >nul 2>&1 && echo   Deleted: %%~T
)

echo.
echo ============================================================
echo  [Step 5/6] Cleaning up registry...
echo  "Digging out Microsoft's roots from your system..."
echo  "Fuck Microsoft for making this so complicated."
echo ============================================================
set "regDel="
set "regDel=!regDel! "HKLM\SOFTWARE\Microsoft\Office\ClickToRun""
set "regDel=!regDel! "HKLM\SOFTWARE\Microsoft\Office\16.0""
set "regDel=!regDel! "HKLM\SOFTWARE\Microsoft\Office\15.0""
set "regDel=!regDel! "HKLM\SOFTWARE\Microsoft\AppVISV""
set "regDel=!regDel! "HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun""
set "regDel=!regDel! "HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\16.0""
set "regDel=!regDel! "HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0""
set "regDel=!regDel! "HKCU\Software\Microsoft\Office\16.0""
set "regDel=!regDel! "HKCU\Software\Microsoft\Office\15.0""

for %%K in (!regDel!) do (
    reg query %%K >nul 2>&1 && (
        reg delete %%K /f >nul 2>&1 && echo   Purged: %%~K
    )
)

echo.
echo ============================================================
echo  [Step 6/6] Clearing Office installer cache...
echo  "Taking out the last of Microsoft's trash..."
echo ============================================================
if exist "%LocalAppData%\Microsoft\Office\Packages" (
    rd /s /q "%LocalAppData%\Microsoft\Office\Packages" 2>nul
    echo   Cleared installer cache.
)
if exist "%ProgramData%\Microsoft\Office\Patches" (
    rd /s /q "%ProgramData%\Microsoft\Office\Patches" 2>nul
    echo   Cleared patch cache.
)

echo.
color 0A
echo  ============================================================
echo  #                                                          #
echo  #     ____   ___  _   _ _____ _                            #
echo  #    |  _ \ / _ \| \ | | ____| |                           #
echo  #    | | | | | | |  \| |  _| | |                           #
echo  #    | |_| | |_| | |\  | |___|_|                           #
echo  #    |____/ \___/|_| \_|_____(_)                           #
echo  #                                                          #
echo  #  Office has been sent to the shadow realm.               #
echo  #  Your PC is now free from Microsuck's grip.              #
echo  #                                                          #
echo  #  "Fuck Microsoft for making me write this script."       #
echo  #                                                          #
echo  #  Please RESTART your computer before reinstalling.       #
echo  #  (Or don't reinstall. Use LibreOffice. Be free.)         #
echo  #                                                          #
echo  ============================================================
echo.
pause