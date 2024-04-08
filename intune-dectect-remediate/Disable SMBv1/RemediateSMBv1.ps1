# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script disables SMBv1 protocol

$SMBv1 = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

if ($SMBv1 -and $SMBv1.State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
    Write-Host "SMBv1 protocol has been disabled."
    Exit
}
elseif ($SMBv1 -and $SMBv1.State -eq "Disabled") {
    Write-Host "SMBv1 protocol is already disabled."
    Exit
}
elseif ($null -eq $SMBv1) {
    Write-Host "SMBv1 protocol is not found."
    Exit
}
else {
    Write-Host "An error occurred while retrieving SMBv1 protocol information."
    Exit
}