# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script detects SMBv1 protocol

$SMBv1 = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

if ($SMBv1.State -eq "Enabled") {
    
    Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart
    Write-Host "SMBv1 protocol has been disabled."
    Exit
}
else {
    Exit
}