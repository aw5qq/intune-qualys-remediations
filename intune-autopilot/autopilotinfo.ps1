# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script will generate a CSV file with the hardware ID of the device.

# Install the WindowsAutoPilotIntune module
Install-Module -Name WindowsAutoPilotIntune -RequiredVersion 4.8 -Force

# create a folder if it doesn not exist
$folder = "C:\Dell" 
if (!(Test-Path $folder)) {
    New-Item $folder -Type Directory
}

# change to the folder
Set-Location -Path $folder

# download the script
Install-Script -Name Get-WindowsAutoPilotInfo -Force

# run the script
Get-WindowsAutoPilotInfo -OutputFile AutoPilotHWID.csv