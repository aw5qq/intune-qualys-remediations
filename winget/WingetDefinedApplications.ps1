# Author: Andrew Welch (aw5qq@virginia.edu))
# Description: This script will upgrade listed applications using winget

Set-WinUILanguageOverride -Language "en-US"
Set-WinDefaultInputMethodOverride -InputTip "0409:00000409"
Set-WinUserLanguageList -LanguageList "en-US" -Force
Set-WinHomeLocation -GeoId 244

# Get the latest download URL for winget
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe


# Define a list of applications to upgrade
$applications = @(
  "Google.Chrome",
  "Microsoft.Edge",
  #"Microsoft.EdgeWebView2Runtime",
  "Mozilla.Firefox"
  #"VideoLAN.VLC"
  #"Zoom.Zoom"
)

# Check if the alias already exists and remove it if it does
if (Get-Alias sysget -ErrorAction SilentlyContinue) {
  Remove-Item alias:sysget
}

$wingetexe = Get-Command winget.exe -ErrorAction SilentlyContinue

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
    sysget upgrade --id $app --accept-source-agreements --accept-package-agreements 
    # --locale $region --silent --force
  } catch {
    Write-Host "An unexpected error occurred while upgrading ${app}: $_"
  }
}