# Define the source and destination paths
$sourceFile = "$PSScriptRoot\settings.json"
$destinationFile = "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"

# Ensure the destination directory exists
$destinationDir = Split-Path -Path $destinationFile -Parent
if (!(Test-Path -Path $destinationDir)) {
    New-Item -ItemType Directory -Path $destinationDir -Force | Out-Null
}

# Copy the file
if (Test-Path -Path $sourceFile) {
    Copy-Item -Path $sourceFile -Destination $destinationFile -Force
    Write-Host "settings.json successfully copied to $destinationFile"
} else {
    Write-Host "Error: Source file not found at $sourceFile"
}

# Restart the Desktop App Installer
Get-Process -Name DesktopAppInstaller -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Process -FilePath "shell:AppsFolder\Microsoft.DesktopAppInstaller_cw5n1h2txyewy!App" -ErrorAction SilentlyContinue
