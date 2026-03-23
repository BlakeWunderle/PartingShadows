@echo off
echo === Echoes of Choice SteamPipe Upload ===
echo.
echo Make sure you have exported the Windows build to build\windows\ first.
echo.

set /p USERNAME=Enter Steam username:
C:\steamcmd\steamcmd.exe +login %USERNAME% +run_app_build "%~dp0app_build_4545380.vdf" +quit

echo.
echo Upload complete. Check build status in Steamworks.
pause
