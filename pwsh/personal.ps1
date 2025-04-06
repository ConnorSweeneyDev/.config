function attend
{
  cd D:\Python\AttendanceLogger
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  python program\main.py
}
function music
{
  cd C:\Program Files\TuiMusic
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  $arguments = $args
  .\TuiMusic.exe $arguments
}
