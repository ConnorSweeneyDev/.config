function attend
{
  cd D:\Python\AttendanceLogger
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  python program\main.py
}
function music
{
  cd E:\Custom\TuiMusic
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  $arguments = $args
  .\TuiMusic.exe $arguments
}
