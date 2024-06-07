# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script upgrades all installed applications using the Windows Package Manager (winget).

# Install the Windows Package Manager (winget) if it is not already installed
if (-not (Get-Module -Name Microsoft.Winget.Client -ListAvailable)) {
    Install-Module -Name Microsoft.Winget.Client -Force
}

Import-Module -Name Microsoft.Winget.Client -Force 

# Check if the Windows Package Manager (winget) is installed
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    
    Write-Host "The Windows Package Manager (winget) is not installed."
    Write-Host "The Windows Package Manager (winget) is being installed."
    
    # Install the Windows Package Manager (winget) if it is not already installed
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

    # Check if the Windows Package Manager (winget) was installed successfully
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "Failed to install the Windows Package Manager (winget)."
        Exit
    }
    else {
        Write-Host "The Windows Package Manager (winget) has been installed."
    }

} else {
    Write-Host "The Windows Package Manager (winget) is installed."
}

# Get the list of installed applications needing an upgrade
$upgradePackages = winget upgrade --id --name --source --version

if ($upgradePackages.Count -eq 0) {
    Write-Host "No applications needing an upgrade were found."
    Exit
}

# Display upgradeable packages
$upgradePackages | ForEach-Object {
    Write-Host "$($_.Name) - Installed Version: $($_.InstalledVersion) - Available Version: $($_.AvailableVersion)"
}

# Upgrade all applications needing an upgrade
$upgradePackages | ForEach-Object {
    Write-Host "Upgrading $($_.Name) from version $($_.InstalledVersion) to version $($_.AvailableVersion)"
    winget upgrade --id $_.Id --accept-package-agreements --accept-source-agreements
    if ($?) {
        Write-Host "Successfully upgraded $($_.Name) to version $($_.AvailableVersion)"
    } else {
        Write-Host "Failed to upgrade $($_.Name)"
    }
}
