function c { Clear-Host }
function o { opencode }
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

function d
{
  $paths = $args
  foreach ($path in $paths)
  {
    if (Test-Path $path) { Remove-Item $path -Recurse -Force }
    else { echo "Path does not exist: $path" }
  }
}
