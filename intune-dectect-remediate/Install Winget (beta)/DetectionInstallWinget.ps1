# Author: Andrew Welch (aw5qq@virginia.edu))
# Description: This script will install winget

$wingetPackage = Get-AppxPackage -Name Microsoft.DesktopAppInstaller -ErrorAction SilentlyContinue
if ($wingetPackage -eq $null) {
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
}
else {
    Write-Host "Winget is already installed."
}