# This script will check for available updates using the Windows Package Manager (winget) and report the results to the user.

# set variables
$WingetPath = "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_1.11.11401.0_x64__8wekyb3d8bbwe\appxbundlemanifest.xml"

# check if winget is installed
if (Test-Path $WingetPath) {
    # run winget to check for available updates
    Start-Process -FilePath winget -ArgumentList "upgrade --all" -Wait -NoNewWindow
} else {
    Write-Host "winget is not installed on this device."
}

