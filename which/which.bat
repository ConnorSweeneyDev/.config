@ECHO OFF

fzf --border --info=inline --preview "bat --style=numbers --color=always {}" > "%WHICH%\path.txt"

python "%WHICH%\folder.py"
FOR /F "delims=" %%i IN (%WHICH%\path.txt) DO @ECHO %%i
