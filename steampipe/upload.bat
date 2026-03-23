@echo off
echo === Echoes of Choice SteamPipe Upload ===
echo.
echo Export builds to these folders before uploading:
echo   build\windows\  (EchoesOfChoice.exe + .pck + DLLs)
echo   build\linux\    (EchoesOfChoice.x86_64 + .pck + .so)
echo   build\macos\    (EchoesOfChoice.app)
echo.

set /p USERNAME=Enter Steam username:
C:\steamcmd\steamcmd.exe +login %USERNAME% +run_app_build "%~dp0app_build_4545380.vdf" +quit

echo.
echo Upload complete. Check build status in Steamworks.
pause
