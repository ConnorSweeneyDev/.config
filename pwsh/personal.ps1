function attend
{
  cd D:\Python\AttendanceLogger
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  python program/main.py
}
function music
{
  cd D:\CPP\TerminalMusicPlayer
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"

  if ($args.Count -eq 0) { .\binary\TerminalMusicPlayer.exe }
  elseif ($args -eq "-s")
  {
    $directoryPath = Get-Content -Path user\songs_directory.txt -First 1
    $Env:FZF_DEFAULT_OPTS = "--border=rounded --border-label=`" MUSIC `" --tabstop=2 --color=16 --multi"
    $selectedSongs = Get-ChildItem -Path $directoryPath -File | ForEach-Object { $_.Name } | fzf
    if (![string]::IsNullOrWhiteSpace($selectedSongs)) { .\binary\TerminalMusicPlayer.exe $selectedSongs }
  }
  elseif ($args -eq "-c") { .\binary\TerminalMusicPlayer.exe -c }
  elseif ($args -eq "-r") { .\binary\TerminalMusicPlayer.exe -r }
  else { echo "Invalid argument: $args" }
}
