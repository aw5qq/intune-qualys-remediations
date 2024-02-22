# Author: Andrew Welch (aw5qq@virginia.edu))
# Description: This script will upgrade listed applications using winget

# Define a list of applications to upgrade
$applications = @(
  "Mozilla.Firefox",
  "Google.Chrome",
  "Microsoft.Edge"
)

$wingetexe = (Get-Command winget.exe).Source

# Check if the alias already exists
if (Get-Alias sysget -ErrorAction SilentlyContinue) {
  # Remove the alias if it already exists
  Remove-Item alias:sysget
}

# Create the sysget alias so winget can be run as system
New-Alias -Name sysget -Value "$wingetexe" -ErrorAction SilentlyContinue

# Get the current machine region and language
$region = Get-WinSystemLocale
Write-Host $region

# Loop through the list and upgrade each application
foreach ($app in $applications) {
  try {
    sysget upgrade --id $app --accept-package-agreements --include-unknown --accept-source-agreements --locale $region
  } catch {
    Write-Host "An unexpected error occurred while upgrading ${app}: $_"
  }
}