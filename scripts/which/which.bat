@ECHO OFF

fzf --border --info=inline --preview "bat --style=numbers --color=always {}" --preview-window "~3" > "C:\scripts\which\path.txt"

python C:\scripts\which\folder.py

FOR /F "delims=" %%i IN (C:\scripts\which\path.txt) DO @echo %%i
