function c { Clear-Host }
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
