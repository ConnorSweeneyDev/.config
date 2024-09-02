@ECHO OFF

start "" "C:\Program Files\Mozilla Firefox\firefox.exe"

timeout /t 1 /nobreak >nul
nircmd sendkeypress ctrl+0xBC
