# Author: Andrew Welch (aw5qq@virginia.edu))
# Description: This script will upgrade listed applications using winget

# Define a list of applications to upgrade
$applications = @(
  "Mozilla.Firefox",
  "Google.Chrome",
  "Microsoft.Edge",
  "VideoLAN.VLC",
  "Zoom.Zoom"
)

# Check if the alias already exists and remove it if it does
if (Get-Alias sysget -ErrorAction SilentlyContinue) {
  Remove-Item alias:sysget
}

# Check if winget.exe is available
if ($wingetexe) {
  # Create the sysget alias
  New-Alias -Name sysget -Value "$wingetexe" -ErrorAction SilentlyContinue
} else {
  Write-Host "Winget is not installed. Please install winget before running this script."
}

# Define the region to use for the upgrade
$region = "US"

# Loop through the list and upgrade each application
foreach ($app in $applications) {
  try {
    Write-Host "Upgrading application: $app"
    sysget upgrade --id $app --accept-package-agreements --include-unknown --accept-source-agreements --locale $region
  } catch {
    Write-Host "An unexpected error occurred while upgrading ${app}: $_"
  }
}
