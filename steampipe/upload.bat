@echo off
echo === Echoes of Choice SteamPipe Upload ===
echo.

REM Prepare macOS build: unzip and rename .app to remove spaces
if exist "%~dp0..\build\macos\EchoesOfChoice.zip" (
    echo Preparing macOS build...
    if exist "%~dp0..\build\macos\EchoesOfChoice.app" rmdir /s /q "%~dp0..\build\macos\EchoesOfChoice.app"
    if exist "%~dp0..\build\macos\Echoes of Choice.app" rmdir /s /q "%~dp0..\build\macos\Echoes of Choice.app"
    tar -xf "%~dp0..\build\macos\EchoesOfChoice.zip" -C "%~dp0..\build\macos\"
    if exist "%~dp0..\build\macos\Echoes of Choice.app" (
        ren "%~dp0..\build\macos\Echoes of Choice.app" "EchoesOfChoice.app"
        echo   Renamed .app bundle to EchoesOfChoice.app
    )
)

echo.
set /p USERNAME=Enter Steam username:
C:\steamcmd\steamcmd.exe +login %USERNAME% +run_app_build "%~dp0app_build_4545380.vdf" +quit

echo.
echo Upload complete. Check build status in Steamworks.
pause
