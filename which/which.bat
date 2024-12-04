@ECHO OFF

fzf --preview "bat --style=numbers --color=always {}" --preview-window top > "%WHICH%\path.txt"

python "%WHICH%\folder.py"
FOR /F "delims=" %%i IN (%WHICH%\path.txt) DO @ECHO %%i
