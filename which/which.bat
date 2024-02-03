@ECHO OFF

fzf --border --info=inline --preview "bat --style=numbers --color=always {}" --preview-window "~3" > "C:\which\path.txt"

python C:\which\folder.py

FOR /F "delims=" %%i IN (C:\which\path.txt) DO @echo %%i
