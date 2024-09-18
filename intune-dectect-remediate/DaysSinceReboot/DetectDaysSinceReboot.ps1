# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script reports the number of days since the last reboot

# Check if the computer has been rebooted in the last 30 days
$Uptime= get-computerinfo | Select-Object OSUptime 
if ($Uptime.OsUptime.Days -ge 14){
    Write-Output "$($Uptime.OsUptime.Days)"
    Exit 1
}else {
    Write-Output "$($Uptime.OsUptime.Days)"
    Exit 0
}