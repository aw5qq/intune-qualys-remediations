# Author: Andrew Welch (aw5qq@virginia.edu)
# Detection script to check if Winget is installed

$wingetPath = "$env:LOCALAPPDATA\Microsoft\WindowsApps\winget.exe"
write-host $wingetPath

if (Test-Path -Path $wingetPath) {
    Write-Output "Winget is installed."
    #exit 0
} else {
    Write-Output "Winget is not installed."
    #exit 1
}
