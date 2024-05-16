@echo off
start "" "C:\Program Files\Mozilla Firefox\firefox.exe"
timeout /t 1 /nobreak >nul
nircmd sendkeypress tab tab tab tab
nircmd sendkeypress esc