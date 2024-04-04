@echo off
start "" "C:\Program Files\Mozilla Firefox\firefox.exe"
timeout /t 2 /nobreak >nul
nircmd sendkeypress tab tab tab tab
nircmd sendkeypress r