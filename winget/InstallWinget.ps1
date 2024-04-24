# Author: Andrew Welch (aw5qq@virginia.edu))
# Description: This script will install winget if it is not already installed

# Check if package 9NBLGGH4NNS1 is installed
Write-Host "Checking if package 9NBLGGH4NNS1 is installed..."
try {
    $package = winget list --id 9NBLGGH4NNS1 -e
    Write-Host "Package 9NBLGGH4NNS1 is installed."
} catch {
    Write-Host "Package 9NBLGGH4NNS1 is not installed."
}

# Check if Winget is installed
Write-Host "Checking if Winget is installed..."
try {
    $winget = Get-Command winget -ErrorAction Stop
    Write-Host "Winget is installed."
} catch {
    Write-Host "Winget is not installed. Installing now..."
    # Download and install Winget
    Invoke-WebRequest -Uri 'https://aka.ms/winget/install' -OutFile 'WingetInstaller.msi'
    Start-Process msiexec.exe -Wait -ArgumentList '/i WingetInstaller.msi /quiet'
    Write-Host "Winget has been installed."
}

# Upgrade the AppInstaller
winget source update
winget upgrade --id Microsoft.AppInstaller -e --accept-package-agreements --accept-source-agreements --locale US --force --silent --source msstore
