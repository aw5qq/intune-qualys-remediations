# Author: Andrew Welch (aw5qq@virginia.edu)
# Remediation script to install Winget if not present

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

$wingetPath = "$env:LOCALAPPDATA\Microsoft\WindowsApps\winget.exe"

if (-not (Test-Path -Path $wingetPath)) {
    # URL for Winget installation package (replace with the latest version link)
    $installerUrl = "https://github.com/microsoft/winget-cli/releases/download/v1.7.11132/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    

    # Path to save the installer
    $installerPath = "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

    # Download the installer
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

    # Install Winget using Add-AppxPackage
    Add-AppxPackage -Path $installerPath

    Write-Output "Winget has been installed."
    exit 0
} else {
    Write-Output "Winget is already installed."
    exit 0
}
