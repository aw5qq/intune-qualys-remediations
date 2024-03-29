# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script detects SMBv1 protocol

$SMBv1 = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

if ($null -eq $SMBv1) {
    Write-Host "SMBv1 protocol feature not found."
    Exit 0
}
elseif ($SMBv1.State -eq "Enabled") {
    Write-Host "SMBv1 protocol is enabled."
    Exit 1
}
else {
    Write-Host "SMBv1 protocol is disabled."
    Exit 0
}