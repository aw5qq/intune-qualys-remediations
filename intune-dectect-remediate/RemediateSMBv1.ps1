# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script detects SMBv1 protocol

$SMBv1 = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -ErrorAction SilentlyContinue

if ($SMBv1 -and $SMBv1.State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart
    Write-Host "SMBv1 protocol has been disabled."
    Exit
}
elseif ($SMBv1 -and $SMBv1.State -eq "Disabled") {
    Write-Host "SMBv1 protocol is already disabled."
    Exit
}
else {
    Write-Host "SMBv1 protocol is not found."
    Exit
}