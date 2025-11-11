function cl { Clear-Host }
function c { claude }
function n { nvim . }
function v
{
  $solution = Get-ChildItem -Path (Get-Location) -Filter *.sln -File -Recurse -Depth 1 | Select-Object -First 1
  if ($solution)
  {
    $solutionName = $solution.FullName
    devenv "$solutionName"
  }
  else { devenv . }
}

function d # Better rm - Usage: d <path1> <path2> ... <pathN>
{
  $paths = $args
  foreach ($path in $paths)
  {
    if (Test-Path $path) { Remove-Item $path -Recurse -Force }
    else { echo "Path does not exist: $path" }
  }
}
