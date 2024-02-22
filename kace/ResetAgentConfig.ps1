# Author: Andrew Welch (aw5qq@lawschool.virginia.edu)
# This script is used to reset the KACE Agent configuration on a Windows 10 device.

# Set the host and token variables to the KACE server and token for the device.
$HostURL = "KACE_HOST"
$Token = "KACE_TOKEN"

# Set the programFilesPath variable to the path of the KACE Agent installation.
$SystemDrive = $env:SystemDrive
$ProgramFilesPath = Join-Path $SystemDrive "Program Files (x86)\Quest\KACE"

# Change the working directory to the KACE Agent installation and start the AMPTools.exe process with the -resetconf option.
Set-Location $ProgramFilesPath
Start-Process "AMPTools.exe" "-resetconf host=$HostURL token=$Token"


