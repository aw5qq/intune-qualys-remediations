# Author: Andrew Welch (aw5qq@virginia.edu))
# Description: This script will upgrade all apps installed via winget

$wingetexe = (Get-Command winget.exe).Source

# Check if the alias already exists
if (Get-Alias sysget -ErrorAction SilentlyContinue) {
  # Remove the alias if it already exists
  Remove-Item alias:sysget
}

# Create the sysget alias so winget can be ran as system
New-Alias -Name sysget -Value "$wingetexe" -ErrorAction SilentlyContinue

# Get the current machine's 2-letter geographic region
$region = (Get-Culture).TwoLetterISOLanguageName

# Upgrade all apps
try {
    sysget upgrade --accept-package-agreements --all --include-unknown --accept-source-agreements --locale $region
} catch {
    Write-Host "An unexpected error occurred while executing the command: $_"
}
