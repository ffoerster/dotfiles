if (Get-Command "1Password.exe" -ErrorAction SilentlyContinue) {
  Write-Host "1Password is already installed. Skipping"
  exit
}

winget install -e --id AgileBits.1Password
function Add-ToPath {
  param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]
    $dir
  )

  $dir = (Resolve-Path $dir)

  $path = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
  if (!($path.Contains($dir))) {
    # backup the current value
    "PATH=$path" | Set-Content -Path "$env:USERPROFILE/path.env"
    # append dir to path
    [Environment]::SetEnvironmentVariable("PATH", $path + ";$dir", [EnvironmentVariableTarget]::Machine)
    Write-Host "Added $dir to PATH"
    return
  }
  Write-Error "$dir is already in PATH"
}
Add-ToPath "C:\Program Files\1Password"

Write-Host "1Password installed"
