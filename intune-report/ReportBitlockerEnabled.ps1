# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script reports if Bitlocker is enabled

# Check if Bitlocker is enabled
$BitlockerStatus = Get-BitLockerVolume | Select-Object -Property MountPoint, VolumeStatus, ProtectionStatus
if ($BitlockerStatus.VolumeStatus -eq "FullyEncrypted" -and $BitlockerStatus.ProtectionStatus -eq "On") {
    Write-Output "Bitlocker is enabled"
    Exit 0
} else {
    Write-Output "Bitlocker is not enabled"
    Exit 1
}