@echo off
echo === Parting Shadows SteamPipe Upload ===
echo.

REM Prepare macOS build: unzip and rename .app to remove spaces
if exist "%~dp0..\build\macos\PartingShadows.zip" (
    echo Preparing macOS build...
    if exist "%~dp0..\build\macos\PartingShadows.app" rmdir /s /q "%~dp0..\build\macos\PartingShadows.app"
    powershell -Command "Expand-Archive -Path '%~dp0..\build\macos\PartingShadows.zip' -DestinationPath '%~dp0..\build\macos' -Force"
    if exist "%~dp0..\build\macos\Parting Shadows.app" (
        ren "%~dp0..\build\macos\Parting Shadows.app" "PartingShadows.app"
        echo   Renamed .app bundle to PartingShadows.app
    )
)

echo.
set /p USERNAME=Enter Steam username:
C:\steamcmd\steamcmd.exe +login %USERNAME% +run_app_build "%~dp0app_build_4545380.vdf" +quit

echo.
echo Upload complete. Check build status in Steamworks.
pause
