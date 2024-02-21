# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script reports if Bitlocker is enabled

# Check if Bitlocker is enabled
$BitlockerStatus = Get-BitLockerVolume | Select-Object -Property VolumeStatus
if ($BitlockerStatus.VolumeStatus -eq "FullyEncrypted"){
    Write-Output "Bitlocker is enabled"
    Exit 0
}else {
    Write-Output "Bitlocker is not enabled"
    Exit 1
}
